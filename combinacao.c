#include <stdlib.h>
#include <stdio.h>

/**
 * PROTOTIPO da sub-rotina escrita em Assembly
 * (necessario para o compilador C)
 */
unsigned fatorial(unsigned); // Importante definir como unsigned
                             // porque a sub-rotina fatorial usa
                             // a instrucao MUL, e nao IMUL (v.)

int main(void) {
    unsigned n, p, fat_n, fat_p, fat_n_menos_p, C;

    printf("Digite n: ");
    scanf("%u", &n);
    fat_n = fatorial(n);

    printf("Digite p: ");
    scanf("%u", &p);
    fat_p = fatorial(p);

    fat_n_menos_p = fatorial(n - p);

    C = fat_n / (fat_p * fat_n_menos_p);
    printf("C = %u\n", C);

    return EXIT_SUCCESS;
}

