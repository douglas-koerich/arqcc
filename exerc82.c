#include <stdio.h>

#define TAMANHO	20

int main() {
	char string1[TAMANHO], string2[TAMANHO];

	printf("Digite a primeira string: ");
	scanf(" %s", string1);

	printf("Digite a segunda string: ");
	scanf(" %s", string2);

	int retorno = compara(string1, string2);

	if (retorno == -1) {
		printf("As strings sao iguais.\n");
	}
	else {
		printf("As strings diferem no indice %d.\n", retorno);
	}

	return 0;
}
