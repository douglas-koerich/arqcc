#include <stdlib.h>
#include <stdio.h>
#include <time.h>

static void bolha(int* v, long s) {
	long i, j;
	for (i=1; i<=s; ++i) {
		for (j=s-1; j>0; --j) {
			if (v[j] < v[j-1]) {
				int a = v[j];
				v[j] = v[j-1];
				v[j-1] = a;
			}
		}
	}
}

int main(int argc, char* argv[]) {
	if (argc < 3) {
		puts("Numero insuficiente de parametros");
		printf("Uso: %s <arquivo-original> <arquivo-modificado>\n", argv[0]);
		return EXIT_FAILURE;
	}
	FILE* entrada = fopen(argv[1], "rb");
	if (entrada == NULL) {
		perror("Nao pude abrir o arquivo original");
		return EXIT_FAILURE;
	}
	FILE* saida = fopen(argv[2], "wb");
	if (saida == NULL) {
		perror("Nao pude criar o arquivo modificado");
		fclose(entrada);
		return EXIT_FAILURE;
	}
	srand((unsigned) time(0));
	int numbits;
	do {
		printf("Numero de bits para alterar num byte (1-2): ");
		scanf("%d", &numbits);
	} while (numbits <= 0 || numbits > 2);
	int numbytes = 1;
	if (numbits == 1) {
		do {
			printf("Numero de bytes a alterar ao longo do arquivo (1-5): ");
			scanf("%d", &numbytes);
		} while (numbytes <=0 || numbytes > 5);
	}
	int n, ibyte[numbytes];
	fseek(entrada, 0, SEEK_END);
	long size = ftell(entrada);
	fseek(entrada, 0, SEEK_SET);
	for (n=0; n<numbytes; ++n) {
		ibyte[n] = rand() % size;
	}
	bolha(ibyte, numbytes);
	int i;
	for (i=0, n=1; !feof(entrada); ++n) {
		int c = fgetc(entrada);
		if (c == EOF) {
			if (ferror(entrada)) {
				perror("Nao pude ler do arquivo original");
				fclose(entrada);
				fclose(saida);
				return EXIT_FAILURE;
			}
		}
		else {
			unsigned char b = c;
			if (n == ibyte[i]) {
				if (numbits == 2) {
					b ^= 6;
				}
				else {
					b ^= (1 << rand() % 8);
				}
				++i;
			}
			if (fputc(b, saida) == EOF) {
				perror("Nao pude escrever no arquivo modificado");
				fclose(entrada);
				fclose(saida);
				return EXIT_FAILURE;
			}
		}
	}
	fclose(entrada);
	fclose(saida);
	return EXIT_SUCCESS;
}
