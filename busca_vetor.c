#include <stdlib.h>
#include <stdio.h>

int* busca_valor(int, int*, size_t);
void maior_menor_valor(int*, size_t, int*, int*);

#define TAM 10

int main(void) {
    int exemplo[TAM] = { 8, 1, 34, 2, 13, 5, 55, 3, 21, 1 };

    printf("Digite o valor a buscar: ");
    int x;
    scanf("%d", &x);

    int* p = busca_valor(x, exemplo, TAM);
    if (p == NULL) {
        puts("Valor nao encontrado no vetor");
    } else {
        printf("Valor localizado no endereco %p\n", p);
    }

    int maior, menor;
    maior_menor_valor(exemplo, TAM, &menor, &maior);

    printf("O maior valor eh %d e o menor eh %d\n", maior, menor);

    return EXIT_SUCCESS;
}