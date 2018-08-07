#include <stdio.h>
#include "exerc60.h"

int main(void) {
	int x, y, s;
	printf("Digite o 1o. numero: ");
	scanf("%d", &x);
	printf("Digite o 2o. numero: ");
	scanf("%d", &y);
	s = soma(x, y);
	printf("A soma dos inteiros entre %d e %d (inclusive) eh %d.\n",
		   x, y, s);
	return 0;
}

