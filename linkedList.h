
#include <stdbool.h>


enum type {entero = 0, text = 1};

typedef struct node {
    enum type type;
    char * key;
    struct node *next;
}node ;

typedef node * list;

list *createList();
void insert(list *l, char *key, int type);
bool isEmpty(list *l);
node *find(list *l,char * key);
void freeList(list *l);