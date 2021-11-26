%{
    #include "y.tab.h"
%}
FIN_LINEA ";"
IMPRIMIR "imprimir"
CODIGO "codigo:"
%%
[\t] ECHO;

{FIN_LINEA} return FIN_LINEA;
{IMPRIMIR} return IMPRIMIR;
{CODIGO} return CODIGO;

.   ECHO;
\n  ECHO;

%%
int yywrap(void){
    return 1;
}
int yyerror(const char* msg){
    fprintf(stderr, "ERROR: %s\n", msg);
    return 0;
}
