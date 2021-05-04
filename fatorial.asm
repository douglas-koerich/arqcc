section .text
    global main
    extern printf
    extern scanf

main:
    push msg_pedido
    call printf
    add esp, 4

    push numero
    push percent_d
    call scanf
    add esp, 8

    ; fat = 1; // Valor de 'fat' em EAX
    mov eax, 1

    ; for (x = numero; x > 0; --x)  // Valor de 'x' em ECX
    mov ecx, [numero]
    cmp ecx, 0
    je  imprime ; se numero for zero, 0! = 1, nao deve multiplicar

repete:
    ;   fat *= x;
    mul ecx
    loop repete ; salta para 'repete' se ECX > 0, decrementando ECX antes

imprime:
    push eax
    push msg_resultado
    call printf
    add esp, 8

    mov ebx, 0
    mov eax, 1
    int 80h

section .data

msg_pedido:     db "Digite um numero: ",0
percent_d:      db "%d",0
msg_resultado:  db "O fatorial do numero eh %d",10,0

section .bss

numero: resd 1