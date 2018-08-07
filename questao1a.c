#include <stdio.h>

void func(int*, size_t);

#define MAX 7

int main(void) {
	int vetor1[MAX] = { 0, 1, 2, 3, 4, 5, 6 };
	int vetor2[MAX];

	for (int i=0; i<MAX; ++i) {
		vetor2[i] = vetor1[i];
	}

	func(vetor2, MAX);

	for (int i=0; i<MAX; ++i) {
		printf("%d ", vetor2[i]);
	}
	putchar('\n');
	return 0;
}

