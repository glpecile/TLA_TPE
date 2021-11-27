%{
void yyerror(const char *s);
int i = 0;
int yylex();
%}

%token CODIGO
%token FIN_LINEA
%token IMPRIMIR

%start S

%%

S: begin code end;
begin: CODIGO{
    printf("int main(){");
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