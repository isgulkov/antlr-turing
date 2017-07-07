grammar Turing;

/*
 Parser rules
 */

// function declaration isn't considered a statement as it can't be nested

statement
    : assignmentStmt
    | conditionalStmt
    | loopStmt
    | returnStmt
    ;

assignmentStmt
    : ID ':=' expression
    ;

conditionalStmt
    : 'if' expression 'then' NEWLINE
      (statement NEWLINE)*
      ('else' NEWLINE
      (statement NEWLINE)*)?
      'end if'
    ;

loopStmt
    : 'loop' NEWLINE
      (statement NEWLINE)*
      'end loop'
    ;

returnStmt
    : 'result' expression
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

// Couldn't find actual identifier description anywhere, sticking with this
ID : [a-zA-Z][a-zA-Z0-9]* ;

STRING : '"' (~('\r' | '\n' | '"'))* '"' ;

INT : DIGIT+ ;

DIGIT : [0-9] ;

NEWLINE : ('\r' | '\n')+ ;

WS : ( '\t' | ' ' )+ -> channel(HIDDEN) ;
