%{
#include "linkedList.h"

void yyerror(const char *s);
int i = 0;
int yylex();
%}

%union{
    char texto[256];
    int numero;
   }

%token FIN_LINEA
%token VAR_NUMERO
%token VAR_CHAR
%token VAR_STRING
%token CONST
%token MAS
%token MENOS
%token POR
%token DIVIDIDO
%token MOD
%token VERDADERO
%token FALSO
%token MENOR
%token MENOR_IGUAL
%token MAYOR
%token MAYOR_IGUAL
%token IGUAL
%token DISTINTO
%token Y
%token O
%token NO
%token ASIGNACION
%token PARENTESIS_ABRE
%token PARENTESIS_CIERRA
%token LLAVE_ABRE
%token LLAVE_CIERRA
%token COMILLA
%token SI
%token SI_NO
%token HACER
%token MIENTRAS
%token LEER
%token IMPRIMIR
%token <oracion> TEXTO
%token <numero> NUMERO
%token <oracion> NOMBRE
%token CODIGO

%start S

%%

S: begin code end;
begin: CODIGO{
    printf("#include \"linkedList.h\" \nint main(){");
};
end: {
    printf("\n}");
};

code: | instrucciones ;
instrucciones: instruccion FIN_LINEA | instruccion FIN_LINEA instrucciones;

instruccion: print{};

print : IMPRIMIR {printf("printf(%s\n);", "\"imprime esto\"");}
%%
int main(void){
    yyparse();
}