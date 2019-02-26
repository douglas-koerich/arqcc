#include <stdbool.h>
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
    bool ascii = true;
    while (!feof(arquivo)) {
        char c = fgetc(arquivo);
        if (c == EOF) {
            if (ferror(arquivo)) {
                perror("Erro de leitura do arquivo");
                fclose(arquivo);
                return EXIT_FAILURE;
            }
        } else if (c & 0x80) {
            ascii = false;
            break;
        }
    }
    printf("O tipo do arquivo %s eh %s\n", argv[1], ascii? "ASCII": "UTF");
    return EXIT_SUCCESS;
}

