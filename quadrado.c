#include <stdlib.h>
#include <stdio.h>

int quadrado(int);

int main(void) {
    int x, y;
    printf("Digite um numero: ");
    scanf("%d", &x);

    y = quadrado(x);

    printf("O quadrado do numero eh %d.\n", y);

    return EXIT_SUCCESS;
}

int quadrado(int x) {
    int q;
    q = x * x;
    return q;
}

