%{
	#include "./json.tab.h"
%}

blanks          [ \t\n]+
HEX_DIGIT		[0-9a-f]

UNESCAPEDCHAR [ -!#-\[\]-~]
ESCAPEDCHAR \\["\\bfnrt/]
HEXCHAR \\u{HEX_DIGIT}{HEX_DIGIT}{HEX_DIGIT}{HEX_DIGIT}
CHAR {HEXCHAR}|{ESCAPEDCHAR}|{UNESCAPEDCHAR}
CHARS {CHAR}+
DBL_QUTAT ["]

DIGIT_1_9 [1-9]
DIGIT [0-9]
DIGITS {DIGIT}+
INT {DIGIT}|{DIGIT_1_9}{DIGITS}|-{DIGIT}|-{DIGIT_1_9}{DIGITS}
FRAC [.]{DIGITS}
FLOAT {DIGITS}{FRAC}
E 	[eE][+-]?
EXP	{E}{DIGITS}
NUMBER {INT}|{FLOAT}|{INT}{EXP}|{FLOAT}{EXP}

%%

{blanks} {/* ignore */}
"{"				return(BRACE_OPEN);
"}"				return(BRACE_CLOSE);
"\"" return QUTATIONS;
":" return COLON ;
"," return COMMA;
"[" return BRACEKET_OPEN;
"]" return BRACEKET_CLOSE;
"true" return TRUE_VALUE;
"false" return FALSE_VALUE;
"null" {
	
	return NULL_VALUE;
}

{NUMBER} {
	yylval.stringValue = malloc(sizeof(char)*(strlen(yytext)+1));
	strncpy(yylval.stringValue, yytext, strlen(yytext));

	return (NUMBER);
}

{DBL_QUTAT}{DBL_QUTAT}|{DBL_QUTAT}{CHARS}{DBL_QUTAT} {
	yylval.stringValue = malloc(sizeof(char)*(strlen(yytext)+1));
	strncpy(yylval.stringValue, yytext, strlen(yytext));

	return(STRING);
}
