%include "io.inc"

section .text
    global main
    extern printf
    extern scanf

; main()
main:
    mov ebp, esp; for correct debugging
    PRINT_STRING msg
    GET_DEC 4, numero

    ; if (numero % 2 == 0)
        ; printf("par");
    ; else
        ; printf("impar");

    xor edx, edx ; parte "alta" do grande numero (64 bits)
                 ; a ser dividido
    mov eax, [numero] ; parte "baixa" (32 bits de "baixo")
    mov ebx, 2   ; ebx tem o divisor
    idiv ebx

    cmp edx, 0
    je igual    ; salta se igual (if == 0)

    ; sequencia eh o else (<> 0)
    PRINT_STRING impar
    jmp fim

igual:  ; rotulo/endereco de codigo dentro da funcao main()
    PRINT_STRING par

fim:
    ; return EXIT_SUCCESS;
    mov ebx, 0
    mov eax, 1
    int 80h

section .data
msg:    db  'Digite um numero: ',0
fmt:    db  '%d',0
par:    db  'O numero eh par',10,0
impar:  db  'O numero eh impar',10,0

section .bss
numero: resd 1
