.PHONY = clean all

all:
	lex -o lex.yy.c lex.l
	bison -b y -v -dy syntax.y
	gcc -o programAR.out lex.yy.c y.tab.c linkedList.c -g -fsanitize=address

clean:
	rm -f $(filter-out $(linkedList.c), $(*.c)) *.out *.o lex.yy.c y.tab.c y.tab.h y.output test1