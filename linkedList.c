#include "linkedList.h"
#include <stdlib.h>
#include <stdio.h>
#include <string.h>


// int main() {
//     list *lista = createList();
//     insert(lista,"hola",2);
//     insert(lista,"hola2",1);

//     printf("%d\n",isEmpty(lista));

//     node* finded = find(lista,"hola3");
//     printf("%s\n",finded == NULL? "not found" : "founded");

//     freeList(lista);

//     return 0;
// }

list *createList() {
    list *ans = malloc(sizeof(list));
    *ans = (node *) calloc(1, sizeof(node));
    (*ans)->key = calloc(strlen("head")+1,sizeof(char));
    strcpy((*ans)->key,"head");
    (*ans)->next = NULL;

    return ans;
}

void insert(list * l, char *key, int type) {
    node *aux = (node *) malloc(sizeof(node));

    int keyLen = strlen(key);

    aux->key = (char *) calloc( keyLen +1,sizeof(char));

    memcpy(aux->key,key,keyLen);

    aux->type = type;

    if (l == NULL) {
        printf("creating new list");
        l = createList();
    }
    aux->next = *l;
    *l = aux;
}

bool isEmpty(list *l) {
    return (*l)->key == NULL;
}

node *find(list *l,char * key) {
    if (l != NULL && isEmpty(l) || l == NULL) {
        return NULL;
    }

    node *aux = *l;

    while (strcmp(aux->key,key) != 0) {
        if (aux->next == NULL) {
            return NULL;
        }
        aux = aux->next;
    }
    return aux;
    
}

void freeList(list *l){
   struct node *aux = *l;
   struct node *next;
   while (aux != NULL) {
      next = aux->next;
      if (aux -> key != NULL)
        free(aux->key);
      free(aux);
      aux=next;
   }
   free(l);
}
