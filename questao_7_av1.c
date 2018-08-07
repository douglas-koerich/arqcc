#include <stdio.h>

int main(void) {
    float f = -51.6875;
    int* p = (int*) &f;
    printf("f = %08x\n", *p);
    return 0;
}

