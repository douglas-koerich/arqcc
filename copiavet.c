#include <stdio.h>

#define TAM   8
int fibonacci[TAM] = { 1, 2, 3, 5, 8, 13, 21, 34 };
int vetor[TAM];

int main(void) {
    int i;
    for (i=0; i<TAM; ++i) {
        vetor[i] = fibonacci[i];
    }
    for (i=0; i<TAM; ++i) {
        printf("%d ", vetor[i]);
    }
    putchar('\n');
    return 0;
}
