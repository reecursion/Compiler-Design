%{
#include<stdio.h>
#include<stdlib.h>
%}

preprocessor_directive ^#.*
multi_line_comment \/\*(.*\n)*.*\*\/
single_line_comment \/\/(.)*
keyword auto|double|struct|break|else|long|switch|case|enum|register|typedef|char|extern|return|union|const|float|short|unsigned|continue|for|signed|void|defult|goto|sizeof|volatile|do|if|static|while|asm|dynamic_cast|namespace|reinterpret_cast|bool|explicit|new|static_cast|catch|false|operator|template|class|friend|private|this|const_cast|inline|public|throw|delete|mutable|protected|true|try|typeid|typename|using|virtual|wchar_t|int
identifier [_A-Za-z][_A-Za-z0-9]*
arithmetic_operators \+|\-|\*|\/|\%
arithmetic_assignment_operator "+="|"-="|"*="|"/="|"%="
logical_operator &&|\|\|!
relational_operator <|<=|>|>=|==|!=
bitwise_operator "^"|"&"|"<<"|">>"
unary_operator "-"|"++"|"--"
assignment_operator =
special_character ";"|","|"."|"["|"]"|"("|")"|"{"|"}"|"["|"]"
function {identifier}\(.*\)
realconst (\+|\-)?[0-9]+\.[0-9]+
intconst (\+|\-)?[0-9]+
charconst \'[a-zA-Z]\'
stringconst \"[a-z A-Z]+\"
%%
[ \t\n]+ /* do nothing */
{single_line_comment} {printf("|\t%-40s\t|\t%-30s\t|\n+-----------------------------------------------------------------------------------------------+\n", yytext, "Single line comment");}
{multi_line_comment} {
	int flag = 0;
	char * lines = strtok(yytext,"\n");
	
	while (lines){
		if (!flag)
		{
			printf("|\t%-40s\t|\t%-30s\t|\n", lines, "Multi line comment");
			flag = 1;
		}
		else
			printf("|\t%-40s\t|\t%-30s\t|\n", lines, "");
		lines = strtok(NULL, "\n");	
		if (lines == NULL)
			printf("+-----------------------------------------------------------------------------------------------+\n");
	}
	
}
{preprocessor_directive} {printf("|\t%-40s\t|\t%-30s\t|\n+-----------------------------------------------------------------------------------------------+\n", yytext, "Preprocessor Directive");}
{keyword} {printf("|\t%-40s\t|\t%-30s\t|\n+-----------------------------------------------------------------------------------------------+\n", yytext, "Keyword"); }
{function} {printf("|\t%-40s\t|\t%-30s\t|\n+-----------------------------------------------------------------------------------------------+\n", yytext, "Function");}
{realconst} {printf("|\t%-40s\t|\t%-30s\t|\n+-----------------------------------------------------------------------------------------------+\n", yytext, "Real Constant");}
{intconst} {printf("|\t%-40s\t|\t%-30s\t|\n+-----------------------------------------------------------------------------------------------+\n", yytext, "Integer Constant");}
{charconst} {printf("|\t%-40s\t|\t%-30s\t|\n+-----------------------------------------------------------------------------------------------+\n", yytext, "Character Constant");}
{stringconst} {printf("|\t%-40s\t|\t%-30s\t|\n+-----------------------------------------------------------------------------------------------+\n", yytext, "String Constant");}
{identifier} {printf("|\t%-40s\t|\t%-30s\t|\n+-----------------------------------------------------------------------------------------------+\n", yytext, "Identifier");}
{arithmetic_operators} {printf("|\t%-40s\t|\t%-30s\t|\n+-----------------------------------------------------------------------------------------------+\n", yytext, "Arithmetic Operators");}
{arithmetic_assignment_operator} {printf("|\t%-40s\t|\t%-30s\t|\n+-----------------------------------------------------------------------------------------------+\n", yytext, "Arithmetic Assignment Operator");}
{logical_operator} {printf("|\t%-40s\t|\t%-30s\t|\n+-----------------------------------------------------------------------------------------------+\n", yytext, "Logical Operator");}
{relational_operator} {printf("|\t%-40s\t|\t%-30s\t|\n+-----------------------------------------------------------------------------------------------+\n", yytext, "Relational Operator");}
{bitwise_operator} {printf("|\t%-40s\t|\t%-30s\t|\n+-----------------------------------------------------------------------------------------------+\n", yytext, "Bitwise Operator");}
{unary_operator} {printf("|\t%-40s\t|\t%-30s\t|\n+-----------------------------------------------------------------------------------------------+\n", yytext, "Unary Operator");}
{assignment_operator} {printf("|\t%-40s\t|\t%-30s\t|\n+-----------------------------------------------------------------------------------------------+\n", yytext, "Assignment Operator");}
{special_character} {printf("|\t%-40s\t|\t%-30s\t|\n+-----------------------------------------------------------------------------------------------+\n", yytext, "Special Character");}
%%

int main()
{	
	printf("+-----------------------------------------------------------------------------------------------+\n|\t%-40s\t|\t%-30s\t|\n+-----------------------------------------------------------------------------------------------+\n", "Token", "Token Type");
	yylex();
	return(0);
}
