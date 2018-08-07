#ifndef TRABALHO_H
#define TRABALHO_H

typedef signed short int fp9by7;
typedef unsigned char byte;

fp9by7 __in__(void);                            // retorna um número fp9by7 lido do teclado
void __out__(fp9by7 number);                    // imprime number na tela
fp9by7 __sum__(fp9by7 number1, fp9by7 number2); // number1+number2;
void __inc__(fp9by7* number);                   // ++number;
fp9by7 __sub__(fp9by7 number1, fp9by7 number2); // number1-number2;
void __dec__(fp9by7* number);                   // --number;
fp9by7 __mul__(fp9by7 number1, fp9by7 number2); // number1*number2;
fp9by7 __div__(fp9by7 number1, fp9by7 number2); // number1/number2;
fp9by7 __pow__(fp9by7 number1, byte number2);   // number1^number2;

#endif
