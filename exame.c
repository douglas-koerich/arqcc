#include <stdlib.h>
#include <stdio.h>

int main(void) {
    float f1 = 19.86125;
    float f2 = 7.1035;

    printf("f1 = %f, %#x\n", f1, *((int*)&f1));
    printf("f2 = %f, %#x\n", f2, *((int*)&f2));

    return EXIT_SUCCESS;
}

