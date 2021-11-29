%{
    #include "y.tab.h"
    #include <string.h>
%}
FIN_LINEA               ";"
VAR_NUMERO              "numero "
VAR_CHAR                "letra "
VAR_STRING              "texto "
CONST                   "no cambia "
MAS                     "+"
MENOS                   "-"
POR                     "*"
DIVIDIDO                "/"
MOD                     "modulo"
VERDADERO               "verdadero"
FALSO                   "falso"
MENOR                   "vale menos que "
MAYOR                   "vale mas que "
MENOR_IGUAL             "es igual o vale menos que "
MAYOR_IGUAL             "es igual o vale mas que "
IGUAL                   "es igual a "
DISTINTO                "es distinto de "
Y                       "y "
O                       "o "
NO                      "opuesto de "
ASIGNACION              "vale "
PARENTESIS_ABRE         "("
PARENTESIS_CIERRA       ")"
LLAVE_ABRE              "{"
LLAVE_CIERRA            "}"
COMILLA                 ["]
SI                      "si se cumple("
SI_NO                   "} si no {"
HACER                   "hacer{"
MIENTRAS                "mientras("
LEER                    "leer"
IMPRIMIR                "imprimir"
TEXTO                   ["][^\n\r]*["]
NUMERO                  [-]?[0-9]+
NOMBRE                  [a-z|A-Z|0-9|_]+
CODIGO                  "codigo:"

%%
[\t] ECHO;
[\n] {ECHO; yylineno++;};

{FIN_LINEA}             return FIN_LINEA;
{VAR_NUMERO}            return VAR_NUMERO;
{VAR_CHAR}              return VAR_CHAR;
{VAR_STRING}            return VAR_STRING;
{CONST}                 return CONST;
{MAS}                   return MAS;
{MENOS}                 return MENOS;
{POR}                   return POR;
{DIVIDIDO}              return DIVIDIDO;
{MOD}                   return MOD;
{VERDADERO}             return VERDADERO;
{FALSO}                 return FALSO;
{MENOR}                 return MENOR;
{MAYOR}                 return MAYOR;
{MENOR_IGUAL}           return MENOR_IGUAL;
{MAYOR_IGUAL}           return MAYOR_IGUAL;
{IGUAL}                 return IGUAL;
{DISTINTO}              return DISTINTO;
{Y}                     return Y;
{O}                     return O;
{NO}                    return NO;
{ASIGNACION}            return ASIGNACION;
{PARENTESIS_ABRE}       return PARENTESIS_ABRE;
{PARENTESIS_CIERRA}     return PARENTESIS_CIERRA;
{LLAVE_ABRE}            return LLAVE_ABRE;
{LLAVE_CIERRA}          return LLAVE_CIERRA;
{COMILLA}               return COMILLA;
{SI}                    return SI;
{SI_NO}                 return SI_NO;
{HACER}                 return HACER;
{MIENTRAS}              return MIENTRAS;
{LEER}                  return LEER;
{IMPRIMIR}              return IMPRIMIR;
{TEXTO}                 {strcpy(yylval.texto, yytext); return TEXTO;}
{NUMERO}                {yylval.numero = atoi(yytext); return NUMERO;}
{NOMBRE}                {strcpy(yylval.texto, yytext); return NOMBRE;}
{CODIGO}                return CODIGO;

.   ECHO;

%%

int yywrap(void){
    return 1;
}
int yyerror(const char* msg){
    fprintf(stderr, "ERROR: %s\n", msg);
    return 0;
}
