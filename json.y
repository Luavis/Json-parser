%{
	#include <stdio.h>
%}

%union {
	char * stringValue;
};

// symbols
%token <stringValue> STRING
%token QUTATIONS
%token COLON
%token BRACE_OPEN
%token BRACE_CLOSE
%token BRACEKET_OPEN
%token BRACEKET_CLOSE

%token COMMA
%token <stringValue> NUMBER
%token <stringValue> TRUE_VALUE
%token <stringValue> FALSE_VALUE
%token <stringValue> NULL_VALUE
%type <stringValue> VALUE
%start START

%%

START:
	DICTIONARY
	| ARRAY
	;

DICTIONARY: 
	BRACE_OPEN DICTIONARY_VALUES BRACE_CLOSE
	|
	BRACE_OPEN BRACE_CLOSE
	;

DICTIONARY_VALUES:
	DICTIONARY_VALUE
	| DICTIONARY_VALUE COMMA DICTIONARY_VALUES
	;

VALUE:
	STRING {$$ = $1;}
	| NUMBER {$$ = $1;}
	| TRUE_VALUE {$$ = $1;}
	| FALSE_VALUE {$$ = $1;}
	| NULL_VALUE {$$ = $1;}
	;

ARRAY:
	BRACEKET_OPEN BRACEKET_CLOSE
	| BRACEKET_OPEN ARRAY_VALUE BRACEKET_CLOSE
	;
	
ARRAY_VALUE:
	VALUE {
		printf("array value : %s\n", $1);
	}
	| VALUE COMMA ARRAY_VALUE {
		printf("array value : %s\n", $1);
	}

DICTIONARY_VALUE:
	STRING COLON VALUE {

		printf("key : %s, value : %s\n", $1, $3);
    }
	;

%%

int yyerror(char * s) {
	printf("yyerror : %s\n",s);
}

int main(void) {
	yyparse();
}