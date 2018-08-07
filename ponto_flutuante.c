#include <stdio.h>

int main() {
    float x = 114.6304;
    int* p = (int*) &x;
    printf("x = %x\n", *p);

    float y = -x / 0.0;
    p = (int*) &y;
    printf("y = %f (%x)\n", y, *p);

    y = 0.0 / 0.0;
    printf("y = %f (%x)\n", y, *p);

    return 0;
}
