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
%token SI
%token SI_NO
%token HACER
%token MIENTRAS
%token LEER
%token IMPRIMIR
%token <texto> TEXTO
%token <numero> NUMERO
%token <texto> NOMBRE
%token <texto> COMENTARIO
%token CODIGO

%start S

%%

S: inicio declaraciones rutina final;

inicio: CODIGO{
    printf("#include \"linkedList.h\" \nint main(){");
};

final:{
    printf("\n}");
};

declaraciones: | declar;

declar: decl FIN_LINEA | decl FIN_LINEA declar ;

decl: declaracion {} | declaracion_y_asignacion {} ;

rutina: | rutr

rutr: instruccion FIN_LINEA | instruccion FIN_LINEA rutr | control_logico | control_logico rutr | read | read rutr | impr | impr rutr| comentario {} | comentario {} rutr;

instruccion: asignacion {};

impr: print FIN_LINEA ;

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
            else{
                insert(l,$2, entero);
                printf("int %s ", $2);
            }
}| VAR_STRING NOMBRE{
     if(find(l,$2)!=NULL){
             yyerror("Variable ya definida");
             fprintf(stderr, "La variable ya se definio previamente");
             YYABORT;
         }
         else{
             insert(l,$2, text);
             //printf("char %s[%d + 1] ", $2, MAX_LENGTH);
             printf("char * %s", $2);
         }
 };

nombre_st: NOMBRE{
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

boolean: VERDADERO {printf("1");} | FALSO {printf("0");};

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
    | parentesis_st_abre operacion parentesis_st_cierra;

control_logico: super_si | super_si_sino| super_hacer;

super_si: si_st sentencia_booleana entonces rutina fin_si;
super_si_sino: si_st sentencia_booleana entonces rutina si_no_st rutina fin_si;

si_st: SI PARENTESIS_ABRE {printf("if(");};

entonces: PARENTESIS_CIERRA LLAVE_ABRE {printf(") {");};

fin_si: LLAVE_CIERRA {printf("}");};

si_no_st: LLAVE_CIERRA SI_NO LLAVE_ABRE {printf("} else {");};

super_hacer: hacer_st rutina fin_hacer mientras_st sentencia_booleana fin_mientras;

hacer_st: HACER LLAVE_ABRE {printf("do {");};

fin_hacer: LLAVE_CIERRA {printf("}");};

mientras_st: MIENTRAS PARENTESIS_ABRE{printf("while(");};

fin_mientras: parentesis_st_cierra FIN_LINEA {printf(";\n");};

asignacion: nombre_st asignacion_numero | nombre_st asignacion_texto;

asignacion_numero: asignacion_st valor{printf(";");};

asignacion_texto: asignacion_st texto_st{printf(";");};

asignacion_st: ASIGNACION {printf("=");};

texto_st: TEXTO {printf("%s", $1);};

declaracion_y_asignacion: declaracion_nombre_string asignacion_texto |declaracion_nombre_string asignacion_numero;

print : imprimir_pabr TEXTO PARENTESIS_CIERRA {printf("printf(%s);", $2);}
            | imprimir_pabr NOMBRE PARENTESIS_CIERRA{
            struct node *aux;
            if((aux=find(l,$2)) != NULL){
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

imprimir_pabr: IMPRIMIR PARENTESIS_ABRE;

read: LEER PARENTESIS_ABRE NOMBRE PARENTESIS_CIERRA FIN_LINEA{
     struct node * aux;
     if((aux=find(l, $3)) == NULL){
        yyerror("La variable que se intento asignar no existe\n");
        fprintf(stderr, "La variable que se intento leer no existe\n");
        YYABORT;
     } else if (aux->type == text) {
        printf(" char aux_sc%d[%d];\n", i ,256 + 1);
        printf("scanf(\"%%s\", aux_sc%d);\n", i);
        printf("%s  = aux_sc%d;\n", $3,i++);
     } else if (aux->type == entero) {
        printf("scanf(\"%%d\", &%s);\n", $3);         
     } else {
        yyerror("Error en el tipo de dato de la variable\n");
        fprintf(stderr, "Error en el tipo de dato de la variable\n");
        YYABORT;         
     }
     
};

comentario: COMENTARIO {
    int len = strlen($1);
    char* comment = $1;
    char* aux = calloc(1, (len - 1 )* sizeof(char));
    for(int i = 1; i < len-1; i++){
    aux[i-1] = comment[i];
    }
    printf("/*%s*/", aux);
    free(aux);
};


%%
int main(void){
    l = createList();
    yyparse();
    freeList(l);
}