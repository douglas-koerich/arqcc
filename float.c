#include <stdlib.h>
#include <stdio.h>
#include <math.h>

int main(void) {
    FILE* arq = fopen("/tmp/float.bin", "w");
    if (arq == NULL) {
        perror("Erro ao criar o arquivo");
        return EXIT_FAILURE;
    }
    float positivo = +1.40625 * powf(2, 5);
    float negativo = -1.40625 * powf(2, -5);

    fwrite(&positivo, sizeof(float), 1, arq);
    fwrite(&negativo, sizeof(float), 1, arq);

    fclose(arq);

    // Veja o conteudo do arquivo gerado usando a
    // linha de comando: cat /tmp/float.bin; voce
    // vai encontrar os 4 bytes da precisao simples
    // do IEEE 754 de cada numero, em little-endian

    return EXIT_SUCCESS;
}

