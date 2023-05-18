%{
#include <stdio.h>
#include <stdlib.h>
%}

// Define the precedence and associativity of operators
%left '+' '-'
%left '*' '/'
%right UMINUS

// Define the non-terminals and terminals used in the grammar
%token SELECT FROM WHERE AND OR NOT 
%token INSERT INTO VALUES UPDATE SET 
%token DELETE CREATE TABLE ALTER DROP 
%token PRIMARY KEY VARCHAR INT 
%token BOOL DATE TRUE FALSE
%token <integer> NUMBER
%token <string> STRING
%token <string> IDENTIFIER
%token PLUS MINUS TIMES DIVIDE GT GE LT LE EQ NE
%token LPAREN RPAREN

// Define the start symbol
%start statement

// Define the grammar rules
%%
statement : select_statement
          | insert_statement
          | update_statement
          | delete_statement
          | create_table_statement
          | alter_table_statement
          | drop_table_statement
          ;

select_statement : SELECT select_list FROM table_reference opt_where_clause
                 ;

select_list : IDENTIFIER
            | select_list ',' IDENTIFIER
            ;

table_reference : IDENTIFIER
                ;

opt_where_clause : /* empty */
                 | WHERE expr
                 ;

insert_statement : INSERT INTO IDENTIFIER VALUES LPAREN value_list RPAREN
                 ;

value_list : value
           | value_list ',' value
           ;

value : NUMBER
      | STRING
      | TRUE
      | FALSE
      | NULL
      ;

update_statement : UPDATE IDENTIFIER SET set_clause opt_where_clause
                 ;

set_clause : IDENTIFIER '=' value
           | set_clause ',' IDENTIFIER '=' value
           ;

delete_statement : DELETE FROM IDENTIFIER opt_where_clause
                 ;

create_table_statement : CREATE TABLE IDENTIFIER LPAREN column_list RPAREN
                        ;

column_list : column_definition
            | column_list ',' column_definition
            ;

column_definition : IDENTIFIER type
                  | PRIMARY KEY LPAREN IDENTIFIER RPAREN
                  ;

type : VARCHAR '(' NUMBER ')'
     | INT
     | BOOL
     | DATE
     ;

alter_table_statement : ALTER TABLE IDENTIFIER ADD COLUMN IDENTIFIER type
                      ;

drop_table_statement : DROP TABLE IDENTIFIER
                     ;
%%
// Define the error handling function
void yyerror(const char* s) {
    fprintf(stderr, "Syntax error: %s\n", s);
    exit(EXIT_FAILURE);
}

int main(int argc, char** argv) {
    if(argc == 2)
    {
	yyin = fopen(argv[1], "r");
    yyout = fopen("output.txt", "w");
    }
    while(yyparse())
    {
        fprintf(yyout, "%d %s %d\n", token_id, yytext, yylineno);
    }
    fclose(yyin);
    fclose(yyout);
    return 0;
}
