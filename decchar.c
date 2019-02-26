#include <stdint.h>
#include <stdlib.h>
#include <stdio.h>

int main(int argc, char* argv[]) {
    if (argc < 2) {
        puts("Numero insuficiente de parametros");
        printf("Uso: %s <[caminho-e-]nome-do-arquivo>\n", argv[0]);
        return EXIT_FAILURE;
    }
    FILE* arquivo = fopen(argv[1], "rb");
    if (arquivo == NULL) {
        perror("Erro de abertura do arquivo");
        return EXIT_FAILURE;
    }
    size_t extra = 0;
    uint32_t codigo;
    while (!feof(arquivo)) {
        uint32_t c = fgetc(arquivo);
        if (c == EOF) {
            if (ferror(arquivo)) {
                perror("Erro de leitura do arquivo");
                fclose(arquivo);
                return EXIT_FAILURE;
            }
        } else {
            if ((c & 0x80) == 0) {
                printf("U%04u ", c);
            } else {
                if (extra == 0) {
                    if ((c & 0x20) == 0) {
                        extra = 1;
                        codigo = c & 0x1f;
                    } else if ((c & 0x10) == 0) {
                        extra = 2;
                        codigo = c & 0xf;
                    } else {
                        extra = 3;
                        codigo = c & 7;
                    }
                } else {
                    codigo = codigo << 6;
                    codigo |= (c & 0x3f);
                    if (--extra == 0) {
                        printf("U%04u ", codigo);
                    }
                }
            }
        }
    }
    putchar('\n');
    return EXIT_SUCCESS;
}

