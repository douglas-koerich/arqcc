#include <stdlib.h>
#include <stdio.h>
#include <string.h>

void infence(char*, char*);
void outfence(char*, char*);

int main(int argc, char* argv[]) {
	if (argc < 2) {
		puts("Numero invalido de parametros");
		printf("Use: %s \"mensagem\"\n", argv[0]);
		return EXIT_FAILURE;
	}

	srand(argc == 3? atoi(argv[2]): __LINE__);
	int i;
	printf("Verificacao: ");
	for (i=1; i<=5; ++i) {
		printf("%d ", rand());
	}
	putchar('\n');

	char* indest = (char*) calloc(strlen(argv[1])+1, sizeof(char));
	infence(indest, argv[1]);
	printf("Mensagem original: %s\n", argv[1]);
	printf("Mensagem cifrada: %s\n", indest);

	char* outdest = (char*) calloc(strlen(argv[1])+1, sizeof(char));
	outfence(outdest, indest);
	printf("Mensagem decifrada: %s\n", outdest);

	puts("Brincando com o algoritmo...");
	infence(outdest, indest);
	printf("[IN] Mensagem de origem: %s\n", indest);
	printf("[IN] Mensagem de destino: %s\n", outdest);

	outfence(indest, outdest);
	printf("[OUT] Mensagem de origem: %s\n", outdest);
	printf("[OUT] Mensagem de destino: %s\n", indest);

	puts("Fim do programa...");
	free(indest);
	free(outdest);

	return EXIT_SUCCESS;
}
/*
void infence(char* dest, char* src) {
	int j = 0, i = strlen(src)-1;
	while (i >= 0) {
		dest[j++] = src[i--];
	}
	dest[j] = '\0';
}

void outfence(char* dest, char* src) {
	infence(dest, src);
}
*/

