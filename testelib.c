#include <stdio.h>
#define MAX 20

size_t strlen_dk(const char*);
char* strcpy_dk(char*, const char*);
char* strcat_dk(char*, const char*);
int strcmp_dk(const char*, const char*);

int main(void) {
	char str1[] = "Arquitetura";
	char str2[] = "de Computadores";
	char strA[MAX];
	char strB[2*MAX];

	size_t tamanho = strlen_dk(str1);
	printf("Tamanho de str1: %u.\n", tamanho);

	strcpy_dk(strA, str1);
	printf("Copiada para strA: %s.\n", strA);

	strcpy_dk(strB, strA);
	strcat_dk(strB, str2);
	printf("strB concatenada: %s.\n", strB);

	int compara = strcmp_dk(str1, strA);
	printf("Comparacao de str1 e strA: %d.\n", compara);

	compara = strcmp_dk(strA, strB);
	printf("Comparacao de strA e strB: %d.\n", compara);

	return 0;
}

