#include <stdlib.h>
#include <stdio.h>
#include <time.h>

void soma_l(size_t, int [*][*], int [*][*], int [*][*]);
void soma_c(size_t, int [*][*], int [*][*], int [*][*]);

int main(void) {
    FILE* fp = fopen("/tmp/timesheet.csv", "wt");
    if (fp == NULL) {
        perror("Erro ao criar arquivo de medidas");
        return EXIT_FAILURE;
    }
    fputs("Tamanho;Soma_em_Linhas;Soma_em_Colunas\n", fp);
    size_t tam;
    for (tam=512; tam<=8192; tam+=512) {
        fprintf(fp, "%zd;", tam);

        int* m1 = (int*) malloc(sizeof(int)*tam*tam);
        int* m2 = (int*) malloc(sizeof(int)*tam*tam);
        int* ms = (int*) malloc(sizeof(int)*tam*tam);

        printf("Criando matrizes com %zd linhas/colunas...\n", tam);
        size_t i, j;
        for (i=0; i<tam; ++i) {
            for (j=0; j<tam; ++j) {
                *(m1 + i*tam + j) = i;
                *(m2 + i*tam + j) = j;
            }
        }
        clock_t antes, depois;

        puts("Somando matrizes por linha...");
        antes = clock();
        soma_l(tam, (int(*)[]) m1, (int(*)[]) m2, (int(*)[]) ms);
        depois = clock();
        fprintf(fp, "%lld;", (long long)(depois-antes));

        puts("Somando matrizes por coluna...");
        antes = clock();
        soma_c(tam, (int(*)[]) m1, (int(*)[]) m2, (int(*)[]) ms);
        depois = clock();
        fprintf(fp, "%lld\n", (long long)(depois-antes));

        free(m1);
        free(m2);
        free(ms);
    }
    fclose(fp);
    return EXIT_SUCCESS;
}

void soma_l(size_t t, int m1[t][t], int m2[t][t], int ms[t][t]) {
    size_t l, c;
    for (l=0; l<t; ++l) {
        for (c=0; c<t; ++c) {
            ms[l][c] = m1[l][c] + m2[l][c];
        }
    }
}

void soma_c(size_t t, int m1[t][t], int m2[t][t], int ms[t][t]) {
    size_t l, c;
    for (c=0; c<t; ++c) {
        for (l=0; l<t; ++l) {
            ms[l][c] = m1[l][c] + m2[l][c];
        }
    }
}
