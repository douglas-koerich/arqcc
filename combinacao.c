#include <stdio.h>
#include "subfatorial.h"

int main() {
	int n, p, C, fat_n, fat_p, fat_n_menos_p;
	printf("Digite o numero de elementos (n): ");
	scanf("%d", &n);
	printf("Digite o comprimento da combinacao (p): ");
	scanf("%d", &p);
	fat_n = fatorial(n);
	fat_p = fatorial(p);
	fat_n_menos_p = fatorial(n-p);
	C = fat_n / (fat_p*fat_n_menos_p);
	printf("O numero de combinacoes eh %d\n", C);
	return 0;
}
