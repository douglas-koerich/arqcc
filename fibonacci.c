#include <stdlib.h>
#include <stdio.h>

int n;

int main() {
    do {
        printf("Digite o valor de n: ");
        scanf("%d", &n);
    } while (n < 0);

    if (n < 2) {
        printf("f(%d) = %d\n", n, n);
    } else {
        int f, fn_1 = 1, fn_2 = 0, i;
        for (i = 2; i <= n; ++i) {
            f = fn_1 + fn_2;
            fn_2 = fn_1;
            fn_1 = f;
        }
        printf("f(%d) = %d\n", n, f);
    }
    return 0;
}

