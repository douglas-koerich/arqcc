#include <stdio.h>

#define MAX_STRING  20
char string[MAX_STRING];
char c;
int i;
int achou;
int main(void) {
    printf("Digite uma palavra: ");
    scanf(" %s", string);
    printf("Digite um caractere: ");
    scanf(" %c", &c);
    i = achou = 0;
    while (string[i] != '\0') {
        if (c == string[i]) {
            achou = 1;
            break;
        }
        ++i;
    }
    if (achou) {
        printf("Caractere encontrado!\n");
    } else {
        printf("Caractere nao encontrado!\n");
    }
    return 0;
}
