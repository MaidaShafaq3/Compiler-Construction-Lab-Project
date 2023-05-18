%option noyywrap
%option yylineno

%{
#include <stdio.h>
int token_id = 0;
%}

%%
[ \t\n]+ /*ignores whitespaces*/
"SELECT"	{ token_id++; fprintf(yyout, "%d SELECT, %d\n", token_id, yylineno); }
"FROM"		{ token_id++; fprintf(yyout, "%d FROM, %d\n", token_id, yylineno); }
"WHERE"		{ token_id++; fprintf(yyout, "%d WHERE, %d\n", token_id, yylineno); }
"AND"		{ token_id++; fprintf(yyout, "%d AND, %d\n", token_id, yylineno); }
"OR"		{ token_id++; fprintf(yyout, "%d OR, %d\n", token_id, yylineno); }
"NOT"		{ token_id++; fprintf(yyout, "%d NOT, %d\n", token_id, yylineno); }
"INSERT"	{ token_id++; fprintf(yyout, "%d INSERT, %d\n", token_id, yylineno); }
"INTO"		{ token_id++; fprintf(yyout, "%d INTO, %d\n", token_id, yylineno); }
"VALUES"	{ token_id++; fprintf(yyout, "%d VALUES, %d\n", token_id, yylineno); }
"UPDATE"	{ token_id++; fprintf(yyout, "%d UPDATE, %d\n", token_id, yylineno); }
"SET"		{ token_id++; fprintf(yyout, "%d SET, %d\n", token_id, yylineno); }
"DELETE"	{ token_id++; fprintf(yyout, "%d DELETE, %d\n", token_id, yylineno); }
"CREATE"	{ token_id++; fprintf(yyout, "%d CREATE, %d\n", token_id, yylineno); }
"TABLE"         { token_id++; fprintf(yyout, "%d TABLE, %d\n", token_id, yylineno);}
"ALTER"         { token_id++; fprintf(yyout, "%d ALTER, %d\n", token_id, yylineno);}
"DROP"          { token_id++; fprintf(yyout, "%d DROP, %d\n", token_id, yylineno);}
"PRIMARY"       { token_id++; fprintf(yyout, "%d PRIMARY, %d\n", token_id, yylineno);}
"KEY"           { token_id++; fprintf(yyout, "%d KEY, %d\n", token_id, yylineno);}
"VARCHAR"       { token_id++; fprintf(yyout, "%d VARCHAR, %d\n", token_id, yylineno);}
"INT"           { token_id++; fprintf(yyout, "%d INT, %d\n", token_id, yylineno);}
"BOOL"          { token_id++; fprintf(yyout, "%d BOOL, %d\n", token_id, yylineno);}
"DATE"          { token_id++; fprintf(yyout, "%d DATE, %d\n", token_id, yylineno);}
"TRUE"          { token_id++; fprintf(yyout, "%d TRUE, %d\n", token_id, yylineno);}
"FALSE"         { token_id++; fprintf(yyout, "%d FALSE, %d\n", token_id, yylineno);}
","             { token_id++; fprintf(yyout, "%d ,, %d\n", token_id, yylineno);}
";"             { token_id++; fprintf(yyout, "%d ;, %d\n", token_id, yylineno);}
"+"             { token_id++; fprintf(yyout, "%d +, %d\n", token_id, yylineno);}
"-"             { token_id++; fprintf(yyout, "%d -, %d\n", token_id, yylineno);}
"*"             { token_id++; fprintf(yyout, "%d *, %d\n", token_id, yylineno);}
"/"             { token_id++; fprintf(yyout, "%d /, %d\n", token_id, yylineno);}
">"             { token_id++; fprintf(yyout, "%d >, %d\n", token_id, yylineno);}
">="            { token_id++; fprintf(yyout, "%d >=, %d\n", token_id, yylineno);}
"<"             { token_id++; fprintf(yyout, "%d <, %d\n", token_id, yylineno);}
"<="            { token_id++; fprintf(yyout, "%d <=, %d\n", token_id, yylineno);}
"="             { token_id++; fprintf(yyout, "%d =, %d\n", token_id, yylineno);}
"!="            { token_id++; fprintf(yyout, "%d !=, %d\n", token_id, yylineno);}
'		{ token_id++; fprintf(yyout, "%d ', %d\n", token_id, yylineno);}
"("            	{ token_id++; fprintf(yyout, "%d (, %d\n", token_id, yylineno);}
")"            	{ token_id++; fprintf(yyout, "%d ), %d\n", token_id, yylineno);}
[0-9]+          { token_id++; fprintf(yyout, "%d NUMBER, %d\n", token_id, yylineno);}
[a-zA-Z_][a-zA-Z0-9_]* { fprintf(yyout, "%d ID, %d\n", token_id, yylineno);}
. { printf("Unknown token %s at line %d\n", yytext, yylineno); }
%%

int main(int argc, char** argv) {

yyin = fopen(argv[1], "r");
yyout = fopen("output.txt", "w");

while(yylex())
{
fprintf(yyout, "%d %s %d\n", token_id, yytext, yylineno);
}
fclose(yyin);
fclose(yyout);

return 0;
}
