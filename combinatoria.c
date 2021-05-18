#include <stdlib.h>
#include <stdio.h>

unsigned combinacao(unsigned, unsigned);
unsigned arranjo(unsigned, unsigned);
unsigned fatorial(unsigned);

int main(int argc, char* argv) {
    unsigned n, p;
    
    printf("Digite o numero de elementos do conjunto: ");
    scanf("%u", &n);
    printf("Digite o tamanho de cada tupla formada com os elementos do conjunto: ");
    scanf("%u", &p);

    unsigned C = combinacao(n, p); // quantas tuplas nao importando a ordem
    unsigned A = arranjo(n, p); // quantas tuplas em que a ordem importa

    printf("O numero de combinacoes eh %u e o numero de arranjos eh %u\n",
           C, A);

    return EXIT_SUCCESS;
}

unsigned combinacao(unsigned n, unsigned p) {
    // C = ___ n! ___
    //      (n-p)! p!
    unsigned n_p = n - p;
    unsigned fat_n = fatorial(n);
    unsigned fat_p = fatorial(p);
    unsigned fat_n_p = fatorial(n-p);
    unsigned C = fat_n / (fat_n_p * fat_p);
    return C;
}

unsigned arranjo(unsigned n, unsigned p) {
    // A = __ n! __
    //      (n-p)!
    return fatorial(n) / fatorial(n - p);
}

/*
unsigned fatorial(unsigned x) {
    unsigned f = 1;
    unsigned i;
    for (i = x; i > 0; --i) {
        f *= i;
    }
    return f;
}
*/