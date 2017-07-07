grammar Turing;

/*
 Parser rules
 */

expression
    : primaryExpr
    ;

primaryExpr
    : '(' expression ')'
    | functionCall
    | INT
    | ID
    ;

functionCall
    : ID '(' ( expression (',' expression)* )? ')'
    ;

/*
 Lexer rules
 */

// Couldn't find actual identifier description anywhere, sticking with this
ID : [a-zA-Z][a-zA-Z0-9]* ;

INT : DIGIT+ ;

DIGIT : [0-9] ;

WS : ( '\t' | ' ' | '\r' | '\n' )+ -> channel(HIDDEN) ;
