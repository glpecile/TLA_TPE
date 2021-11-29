.PHONY = clean all

all:
	lex -o lex.yy.c lex.l
	bison -b y -v -dy syntax.y
	gcc -o programAR.out lex.yy.c y.tab.c linkedList.c -g -fsanitize=address

clean:
	rm -f $(filter-out $(linkedList.c), $(*.c)) *.out *.o lex.yy.c y.tab.c y.tab.h y.output test1
	
test:
	./programAR.out < ./tests/test1.ar > test1.c
	gcc -w -fsanitize=address -g test1.c linkedList.c -o test1
	./programAR.out < ./tests/test2.ar > test2.c
	gcc -w -fsanitize=address -g test2.c linkedList.c -o test2
	./programAR.out < ./tests/test3.ar > test3.c
	gcc -w -fsanitize=address -g test3.c linkedList.c -o test3
	./programAR.out < ./tests/test4.ar > test4.c
	gcc -w -fsanitize=address -g test4.c linkedList.c -o test4
	./programAR.out < ./tests/test5.ar > test5.c
	gcc -w -fsanitize=address -g test5.c linkedList.c -o test5

clean_test:
	rm -f test1 test1.c test2 test2.c test3 test3.c test4 test4.c test5 test5.c

