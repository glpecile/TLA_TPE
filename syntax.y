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

code: | instrucciones ;

instrucciones: instruccion FIN_LINEA | instruccion FIN_LINEA instrucciones;

instruccion: declaracion {} | asignacion {} | declaracion_y_asignacion {} | print {};

declaracion: declaracion_nombre_string{
    printf(";");
};
declaracion_nombre_string: VAR_NUMERO NOMBRE{
    struct list* aux;
    if(find(l,$2)!=NULL){
                yyerror("Variable ya definida");
                fprintf(stderr, "La variable ya se definio previamente");
                YYABORT;
            }
            else {
                insert(l,$2, entero);
                printf("int %s ", $2);
            }
}| VAR_STRING NOMBRE{
     if(find(l,$2)!=NULL){
             yyerror("Variable ya definida");
             fprintf(stderr, "La variable ya se definio previamente");
             YYABORT;
         }
         else {
             insert(l,$2, text);
             //printf("char %s[%d + 1] ", $2, MAX_LENGTH);
             printf("char * %s", $2);
         }
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
        }
    | parentesis_st_abre operacion parentesis_st_cierra
    | ;

control_logico: super_si | super_si_sino| super_hacer;

super_si: si_st sentencia_booleana entonces instrucciones fin_si;
super_si_sino: si_st sentencia_booleana entonces instrucciones si_no_st instrucciones fin_si;

si_st: SI {printf("if(");};

entonces: PARENTESIS_CIERRA {printf(") {");};

fin_si: LLAVE_CIERRA {printf("}");};

si_no_st: SI_NO {printf("} else {");};

super_hacer: hacer_st instrucciones fin_hacer mientras_st sentencia_booleana fin_mientras;

hacer_st: HACER {printf("do{");};

fin_hacer: LLAVE_CIERRA {printf("}");};

mientras_st: MIENTRAS {printf("while(");};

fin_mientras: FIN_LINEA {printf(");\n");};

code: | instrucciones ;

instrucciones: instruccion FIN_LINEA | instruccion FIN_LINEA instrucciones;

asignacion: nombre_st asignacion_numero | nombre_st asignacion_texto;

asignacion_numero: asignacion_st valor{printf(";");};

asignacion_texto: asignacion_st texto_st{printf(";");};

asignacion_st: ASIGNACION {printf("=");};
texto_st: TEXTO {printf("%s", $1);};

declaracion_y_asignacion: declaracion_nombre_string asignacion_texto |declaracion_nombre_string asignacion_numero;

print : IMPRIMIR PARENTESIS_ABRE TEXTO PARENTESIS_CIERRA {printf("printf(%s);", $3);}
            | IMPRIMIR PARENTESIS_ABRE NOMBRE PARENTESIS_CIERRA{
            struct node *aux;
            if((aux=find(l,$3)) != NULL){
                if(aux->type == entero){
                    printf("printf(\"%%d\", %s);", aux->key);
                }
                if(aux->type == text){
                    printf("printf(\"%%s\", %s);", aux->key);
                }
            } else {
                yyerror("La variable que se intento imprimir no existe");
                fprintf(stderr, "La variable que se intento imprimir no existe");
                YYABORT;
            }
};

%%
int main(void){
    l = createList();
    yyparse();
    freeList(l);
}