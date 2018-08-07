#include <stdlib.h>
#include <stdio.h>

unsigned pot(unsigned, unsigned);

int main(void) {
    unsigned base, exp;

    printf("Digite a base: ");
    scanf("%u", &base);
    printf("Digite o expoente: ");
    scanf("%u", &exp);

    unsigned potencia = pot(base, exp);

    printf("%u elevado a %u resulta %u.\n", base, exp, potencia);

    return EXIT_SUCCESS;
}

/*
unsigned pot(unsigned b, unsigned e) {
    unsigned n, p = 1;
    for (n = 1; n <= e; ++n) {
        p = p * b;
    }
    return p;
}
*/
unsigned pot(unsigned b, unsigned e) {
    unsigned p;
    if (e == 0) {
        p = 1;
    } else {
        p = b * pot(b, e - 1);
    }
    return p;
}

