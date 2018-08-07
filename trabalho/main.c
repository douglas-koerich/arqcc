#include <stdlib.h>
#include <stdio.h>
#include "trabalho.h"

int main(int argc, char* argv[]) {
    printf("Digite um primeiro valor real: ");
    fp9by7 n1 = __in__();

    printf("Digite um segundo valor real: ");
    fp9by7 n2 = __in__();

    printf("Os numeros digitados foram ");
    __out__(n1);
    printf(" e ");
    __out__(n2);
    putchar('\n');

    fp9by7 soma = __sum__(n1, n2); printf("Soma = "); __out__(soma); putchar('\n');
    fp9by7 m = n1;
    __inc__(&m); printf("Incremento do primeiro = "); __out__(m); putchar('\n');
    fp9by7 dif = __sub__(n1, n2); printf("Subtracao = "); __out__(dif); putchar('\n');
    m = n2;
    __dec__(&m); printf("Decremento do segundo = "); __out__(m); putchar('\n');

    fp9by7 mult = __mul__(n1, n2); printf("Produto = "); __out__(mult); putchar('\n');
    fp9by7 quoc = __div__(n1, n2); printf("Divisao = "); __out__(quoc); putchar('\n');

    fp9by7 pot2 = __pow__(n1, 2); printf("Quadrado do primeiro = "); __out__(pot2); putchar('\n');
    fp9by7 pot3 = __pow__(n2, 3); printf("Cubo do segundo = "); __out__(pot3); putchar('\n');

    return EXIT_SUCCESS;
}
