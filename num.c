#include <stdio.h>

int main() {
	//short int a = 1024, b = -1024;
	// float x = 6.023;
	float x;
	FILE* arq = fopen("/tmp/num.bin", "wb");
	if (arq == NULL) {
		perror("Nao pude criar o arquivo");
		return -1;
	}
	//fwrite(&a, sizeof(short int), 1, arq);
	//fwrite(&b, sizeof(short int), 1, arq);
	x = 1.0/0;
	printf("%f\n", x);
	fwrite(&x, sizeof(float), 1, arq);
	x = 0.0/0;
	printf("%f\n", x);
	fwrite(&x, sizeof(float), 1, arq);

	fclose(arq);
	return 0;
}
