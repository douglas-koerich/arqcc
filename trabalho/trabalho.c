#include <stdio.h>
#include "trabalho.h"

#define UM  0x80    // em binario: 1,000 0000

fp9by7 __in__(void) {
    double d;
    scanf("%lf", &d);
    int b, a = d;
    d -= a;
    fp9by7 i = a * UM, f = 0;
    for (b=1; b<=7; ++b) {
        d *= 2;
        a = d;
        d -= a;
        f = (f << 1) | a;
    }
    return i | f;
}

void __out__(fp9by7 number) {
    double num = number;
    int i;
    for (i=1; i<=7; ++i) {
        num /= 2;
    }
    printf("%16.7lf", num);
}
/*
fp9by7 __sum__(fp9by7 number1, fp9by7 number2) {
    return number1 + number2;
}

void __inc__(fp9by7* number) {
    *number += UM;
}

fp9by7 __sub__(fp9by7 number1, fp9by7 number2) {
    return number1 - number2;
}

void __dec__(fp9by7* number) {
    *number -= UM;
}

fp9by7 __mul__(fp9by7 number1, fp9by7 number2) {
    int m = number1 * number2;
    return (m >> 7) & 0xFFFF;
}

fp9by7 __div__(fp9by7 number1, fp9by7 number2) {
    int d = number1;
    d <<= 7;
    short q = d / number2;
    short r = d % number2;
    return q | r;
}

fp9by7 __pow__(fp9by7 number1, byte number2) {
    fp9by7 p = UM;
    while (number2 > 0) {
        p = __mul__(p, number1);
        --number2;
    }
    return p;
}
*/
