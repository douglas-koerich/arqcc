#include <stdbool.h>
#include <stdlib.h>
#include <stdio.h>
#include <time.h>
#include <math.h>

int main(int argc, char* argv[]) {
    if (argc < 2) {
        puts("Numero insuficiente de parametros");
        printf("Use: %s <nome-arquivo-teste>\n", argv[0]);
        return EXIT_FAILURE;
    }
    srand(time(NULL));

    int num_linhas = rand() % 1000 + 1;
    printf("Gerando arquivo %s com %d linhas...\n", argv[1], num_linhas);
    FILE* arquivo = fopen(argv[1], "wt");
    if (arquivo == NULL) {
        perror("Erro ao criar arquivo");
        return EXIT_FAILURE;
    }
    int l;
    for (l=1; l<=num_linhas; ++l) {
        int num_valores = rand() % 100 + 1;
        printf("Gerando linha %d com %d valores...\n", l, num_valores);
        int n;
        for (n=1; n<=num_valores; ++n) {
            bool real = rand() % 3 == 0;
            bool negativo = rand() % 5 == 0;
            if (real) {
                int num_casas = rand() % 7;
                double valor = rand() % 10000000 / pow(10, num_casas);
                if (negativo) valor = -valor;
                if (fprintf(arquivo, "%.*lf ", num_casas, valor) < 0) {
                    perror("Erro ao gravar numero real");
                    return EXIT_FAILURE;
                }
            } else {
                int valor = rand() % 10000;
                if (negativo) valor = -valor;
                if (fprintf(arquivo, "%d ", valor) < 0) {
                    perror("Erro ao gravar numero inteiro");
                    return EXIT_FAILURE;
                }
            }
        }
        if (fputc('\n', arquivo) == EOF) {
            perror("Erro ao gravar fim da linha");
            return EXIT_FAILURE;
        }
    }
    fclose(arquivo);
    return EXIT_SUCCESS;
}

