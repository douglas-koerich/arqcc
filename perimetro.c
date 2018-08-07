#include <stdio.h>
#include <stdlib.h>

int* vetor;
int lados, soma = 0;

int perimetro(int*, int);

int main(void) {
    // Um programa estupido pra calcular perimetro de um poligono
    printf("Digite o numero de lados que serao informados: ");
    scanf("%d", &lados);

    vetor = (int*) malloc(lados * sizeof(int));
    int i;
    for (i=0; i<lados; ++i) {
        printf("Digite o valor do novo lado: ");
        scanf("%d", vetor+i);   // &vetor[i]
    }

    // for (i=1; i<=lados; ++i) {
    //     soma += vetor[i];
    // }
    soma = perimetro(vetor, lados);

    printf("O perimetro desse poligono eh %d.\n", soma);
    free(vetor);

    return 0;
}

// int perimetro(int* vet, int num) {
//     int s = 0, i;
//     for (i=1; i<=num; ++i) {
//         s += vet[i];
//     }
//     return s;
// }
