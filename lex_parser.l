%option noyywrap
%{
#include <stdio.h>
#include "parser_bis.tab.h" 
%}

%%
"SELECT"        { return SELECT; }
"FROM"          { return FROM; }
"WHERE"         { return WHERE; }
"AND"           { return AND; }
"OR"            { return OR; }
"NOT"           { return NOT; }
"INSERT"        { return INSERT; }
"INTO"          { return INTO; }
"VALUES"        { return VALUES; }
"UPDATE"        { return UPDATE; }
"SET"           { return SET; }
"DELETE"        { return DELETE; }
"CREATE"        { return CREATE; }
"TABLE"         { return TABLE; }
"ALTER"         { return ALTER; }
"DROP"          { return DROP; }
"PRIMARY"       { return PRIMARY; }
"KEY"           { return KEY; }
"VARCHAR"       { return VARCHAR; }
"INT"           { return INT; }
"BOOL"          { return BOOL; }
"DATE"          { return DATE; }
"TRUE"          { return TRUE; }
"FALSE"         { return FALSE; }
"+"             { return PLUS; }
"-"             { return MINUS; }
"*"             { return TIMES; }
"/"             { return DIVIDE; }
">"             { return GT; }
">="            { return GE; }
"<"             { return LT; }
"<="            { return LE; }
"="             { return EQ; }
"!="            { return NE; }
[0-9]+          { return NUMBER; }
\"[^\"]+\"      { return STRING; }
[a-zA-Z_][a-zA-Z0-9_]* { return IDENTIFIER; }
[ \t\n]+        ; // Ignore whitespace and newlines
.               { printf("Unknown token '%s' at line %d\n", yytext, yylineno); }
%%
