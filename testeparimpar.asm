section .text
    global main
    extern printf
    extern scanf

main:
    ; printf("Digite um numero: ");
    push msg_numero
    call printf
    add esp, 4

    ; scanf("%d", &numero);
    push numero
    push percent_d
    call scanf
    add esp, 8

    mov ecx, 2 ; divisor
    mov edx, 0
    mov eax, [numero]
    div ecx ; quociente em EAX, resto em EDX

    ; if (numero % 2 == 0) {
    cmp edx, 0
    jne nao_zero

        ; printf("O numero eh par\n");
    mov ebx, msg_par
    jmp imprime

    ;} else {
nao_zero:
        ; printf("O numero eh impar\n");
    mov ebx, msg_impar

    ;}
imprime:
    push ebx
    call printf
    add esp, 4

    mov ebx, 0
    mov eax, 1
    int 80h

section .data

msg_numero: db  "Digite um numero: ",0
percent_d:  db  "%d",0
msg_par:    db  "O numero eh par",10,0
msg_impar:  db  "O numero eh impar",10,0

section .bss

numero: resd 1