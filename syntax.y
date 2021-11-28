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

sentencia_booleana: boolean
        |boolean sentencia_logica boolean
        |parentesis_st_abre sentencia_booleana parentesis_st_cierra sentencia_logica sentencia_booleana
        |boolean sentencia_logica parentesis_st_abre sentencia_booleana parentesis_st_cierra
        |sentencia_not parentesis_st_abre sentencia_booleana parentesis_st_cierra
        |sentencia_not boolean
        |parentesis_st_abre sentencia_booleana parentesis_st_cierra
        |sentencia_comparativa;

sentencia_not: NO {printf("!");}
        | NO sentencia_not;

sentencia_logica: Y {printf("&&");}
        | O {printf("||");};

operacion: valor operador valor{};

parentesis_st_abre: PARENTESIS_ABRE{printf(" ( ");};
parentesis_st_cierra: PARENTESIS_CIERRA{printf(" ) ");};

boolean: VERDADERO{printf("1");}
        | FALSO{printf("0");};

sentencia_comparativa: valor comparador valor;

comparador: MENOR {printf("<");}
        | MAYOR {printf(">");}
        | MAYOR_IGUAL {printf(">=");}
        | MENOR_IGUAL {printf("<=");}
        | IGUAL{printf("==");}
        | DISTINTO{printf("!=");};

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


super_hacer: hacer_st instrucciones fin_hacer mientras_st sentencia_booleana fin_mientras;

hacer_st: HACER {printf("do{");};

fin_hacer: LLAVE_CIERRA {printf("}");};

mientras_st: MIENTRAS {printf("while(");};

fin_mientras: FIN_LINEA {printf(");\n");};

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