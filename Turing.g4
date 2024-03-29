grammar Turing;

options {
    language = CSharp;
}

/*
 Parser rules
 */

file
    : NEWLINE* ((functionDecl | statement) NEWLINE)* (functionDecl | statement)? EOF
    ;

// function declaration isn't considered a statement as it can't be nested
functionDecl
    : 'function' ID '(' ( formalParam (',' formalParam)* )? ')' ':' TYPENAME NEWLINE
      (statement NEWLINE)*
      'end' ID // The two function IDs should be identical. Not sure if possible with CFGs
    ;

formalParam
    : ID ':' TYPENAME
    ;

statement
    : assignmentStmt
    | conditionalStmt
    | returnStmt
    | variableDeclStmt
    | putStmt
    | functionCallStmt
    ;

functionCallStmt
    : functionCall
    ;

assignmentStmt
    : ID ':=' expression
    ;

conditionalStmt
    : 'if' expression 'then' NEWLINE
      (statement NEWLINE)*
      (else NEWLINE
      (statement NEWLINE)*)?
      'end if'
    ;

// Rule is added so action can be taken in listener when this lexem is encountered
// TODO: figure out how to do this properly
else
    : 'else'
    ;

returnStmt
    : 'result' expression
    ;

variableDeclStmt
    : 'var' ID ':' TYPENAME
    ;

putStmt
    : 'put' ( expression (',' expression)* )?
    ;

expression // comparison expression
    : additiveExpr
    | expression '=' additiveExpr
    ;

additiveExpr
    : multiplicativeExpr
    | additiveExpr '+' multiplicativeExpr
    | additiveExpr '-' multiplicativeExpr
    ;

multiplicativeExpr
    : primaryExpr
    | multiplicativeExpr '*' primaryExpr
    | multiplicativeExpr '/' primaryExpr
    ;

primaryExpr
    : '(' expression ')'
    | functionCall
    | INT
    | ID
    | STRING
    ;

functionCall
    : ID '(' ( expression (',' expression)* )? ')'
    ;

/*
 Lexer rules
 */

// Only one type in the assignment
TYPENAME : 'int' ;

// Couldn't find actual identifier description anywhere, sticking with this
ID : [a-zA-Z][a-zA-Z0-9]* ;

STRING : '"' ( ~('\r' | '\n' | '"') | '\\"' )* '"' ;

INT : '-'? DIGIT+ ;

DIGIT : [0-9] ;

NEWLINE : ('\r' | '\n')+ ;

WS : ( '\t' | ' ' )+ -> channel(HIDDEN) ;
