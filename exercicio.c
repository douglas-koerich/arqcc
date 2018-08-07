#include <stdlib.h>
#include <stdio.h>
#include "exercicio.h"

void imprime_vetor(int* vetor, int tamanho) {
    int i;
    for (i=0; i<tamanho; ++i) {
        printf("%d ", vetor[i]);
    }
}

int main(void) {
    printf("Digite o tamanho maximo do vetor: ");
    int max;
    scanf("%d", &max);

    int vetor[max];

    int i, n;
    for (i=n=0; i<max; ++i) {
        printf("Digite um numero para armazenar na posicao [%d] (<0 para cancelar): ", i);
        scanf("%d", &vetor[i]);
        if (vetor[i] < 0) {
            break;
        }
        ++n;
    }
    printf("Vetor antes da remocao: ");
    imprime_vetor(vetor, n); // n vai ser menor ou igual a max
    putchar('\n');

    int x;
    printf("Digite um valor para busca dos multiplos no vetor: ");
    scanf("%d", &x);

    int removidos;
    removidos = rem_multiplos(vetor, &n, x);

    printf("Vetor depois da remocao: ");
    imprime_vetor(vetor, n); // note que n pode ter sido alterado pela subrotina,
                             // pois eu passei o endereco de n pra ela (como se
                             // faz em C quando uma funcao altera a variavel local
                             // de outra, lembra?)
    printf("\nForam removidos %d elementos do vetor original.\n", removidos);

    return EXIT_SUCCESS;
}

