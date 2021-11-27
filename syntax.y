%{
#include "linkedList.h"

void yyerror(const char *s);
int i = 0;
int yylex();
list *l;
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
%token <texto> TEXTO
%token <numero> NUMERO
%token <texto> NOMBRE
%token CODIGO

%left '+' '-'
%left '*' '/' '%'
%left '(' ')'
%start S

%%

S: begin code end;
begin: CODIGO{
    printf("#include \"linkedList.h\" \nint main(){");
};
end: {
    printf("\n}");
};

nombre_st: NOMBRE {
    struct node* aux;
    if((aux=find(l,$1)) == NULL){
        yyerror("La variable que se intento asignar no existe");
        fprintf(stderr, "La variable que se intento asignar no existe");
        YYABORT;
    }else{
        printf("%s", $1);
    }
};

operacion: valor operador valor{};

parentesis_st_abre: PARENTESIS_ABRE{printf(" ( ");};
parentesis_st_cierra: PARENTESIS_CIERRA{printf(" ) ");};

operador: MAS{printf(" + ");}
        |MENOS{printf(" - ");}
        |POR{printf(" * ");}
        |DIVIDIDO{printf(" / ");}
        |MOD{printf(" %% ");};

        valor: 
    nombre_st
    | NUMERO {
        printf("%d", $1);
        };
    | parentesis_st_abre operacion parentesis_st_cierra
    | ;

code: | instrucciones ;
instrucciones: instruccion FIN_LINEA | instruccion FIN_LINEA instrucciones;

instruccion: print{};

print : IMPRIMIR {printf("printf(%s\n);", "\"imprime esto\"");}
%%
int main(void){
    l = createList();
    yyparse();
    freeList(l);
}