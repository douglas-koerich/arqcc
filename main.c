#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <ctype.h>

#ifndef TESTE
#include "hamming.h"
#else
void salva_hamming(FILE* arqtxt_entrada, FILE* arqbin_saida) {}
int testa_hamming(FILE* arqbin) { return 0; }
#endif

int main(int argc, char* argv[]) {
	if (argc < 3) {
		puts("Numero insuficiente de parametros");
		printf("Use: %s <-s|-t> <nome-arq-entrada> [<nome-arq-saida>]\n",
			argv[0]);
		return EXIT_FAILURE;
	}
	if (strlen(argv[1]) != 2) {
		printf("Parametro 2 invalido: %s\n", argv[1]);
		return EXIT_FAILURE;
	}
	argv[1][1] = tolower(argv[1][1]);
	if (strcmp(argv[1], "-s") &&
		strcmp(argv[1], "-t")) {
		printf("Parametro 2 invalido: %s\n", argv[1]);
		return EXIT_FAILURE;
	}
	if (argv[1][1] == 's') {
		if (argc < 4) {
			puts("Numero insuficiente de parametros");
			printf("Use: %s <-s|-t> <nome-arq-entrada> [<nome-arq-saida>]\n",
				argv[0]);
			return EXIT_FAILURE;
		}
		FILE* entrada = fopen(argv[2], "r");
		if (entrada == NULL) {
			perror("Nao pude abrir o arquivo-texto de entrada");
			return EXIT_FAILURE;
		}
		FILE* saida = fopen(argv[3], "wb");
		if (saida == NULL) {
			perror("Nao pude criar o arquivo-binario de saida");
			fclose(entrada);
			return EXIT_FAILURE;
		}
		salva_hamming(entrada, saida);
		fclose(entrada);
		fclose(saida);
	}
	else {
		FILE* entrada = fopen(argv[2], "rb");
		if (entrada == NULL) {
			perror("Nao pude abrir o arquivo-binario de entrada");
			return EXIT_FAILURE;
		}
		int r = testa_hamming(entrada);
		printf("A funcao de teste retornou %d.\n", r);
		fclose(entrada);
	}
	return EXIT_SUCCESS;
}
