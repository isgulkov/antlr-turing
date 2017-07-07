grammar Turing;

/*
 Parser rules
 */

primaryExpr
    : INT
    | ID
    ;

/*
 Lexer rules
 */

// Couldn't find actual identifier description anywhere, sticking with this
ID : [a-zA-Z][a-zA-Z0-9]* ;

INT : DIGIT+ ;

DIGIT : [0-9] ;
