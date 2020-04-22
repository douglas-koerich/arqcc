#include <stdlib.h>
#include <stdio.h>

long long fatorial(long);

int main(int argc, char* argv[]) {
    if (argc < 3) {
        puts("Numero insuficiente de parametros");
        printf("Uso: %s <num-elem-cjto> <num-elem-grupo>\n", argv[0]);
        return EXIT_FAILURE;
    }
    long n = atoi(argv[1]);
    long p = atoi(argv[2]);

    long combinacao = fatorial(n) / (fatorial(n-p) * fatorial(p));
    long arranjo = fatorial(n) / fatorial(n-p);

    printf("C = %d, A = %d\n", combinacao, arranjo);

    printf("short = %zu\n", sizeof(short));
    printf("long = %zu\n", sizeof(long));
    printf("long long = %zu\n", sizeof(long long));
    printf("int = %zu\n", sizeof(int));

    return EXIT_SUCCESS;
}

/*
long long fatorial(long x) {
    long long f = 1;
    while (x > 0) {
        f *= x;
        --x;
    }
    return f;
}
*/
