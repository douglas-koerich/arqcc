#include <stdlib.h>
#include <stdio.h>

// Prototipo da funcao/sub-rotina
int soma_pg(int a1, int q, int n);

int main(void) {
    int a1;
    printf("Qual o primeiro termo da PG? ");
    scanf("%d", &a1);

    int q;
    printf("Qual a razao da progressao? ");
    scanf("%d", &q);

    int n;
    printf("Quantos termos deve somar? ");
    scanf("%d", &n);

    int soma = soma_pg(a1, q, n);

    printf("A soma dos termos da PG eh %d.\n", soma);

    return EXIT_SUCCESS;
}

