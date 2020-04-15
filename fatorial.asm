section .text
    global main
    extern printf
    extern scanf

main:
    push entnum
    call printf
    add esp, 4

    push num
    push fmtent
    call scanf
    add esp, 8

    ; fat = 1;
    ; while (num > 0) {
    ;     fat *= num; // fat = fat * num;
    ;     --num;
    ; }

    mov ecx, dword [num]
    mov eax, 1 ; EAX "acumula"/armazena o resultado do fatorial

continua:
    mul ecx ; EAX *= ECX
    
    ; Modo "classico" e mais generico para fazer um laco eh usar
    ; as instrucoes de salto ("jump") como abaixo
    ; dec ecx
    ; cmp ecx, 0
    ; ja continua

    ; Mas, no caso deste problema, podemos usar uma UNICA instrucao
    loop continua
    
    ; printf("O fatorial de %u eh %u\n", num, fat);
    push eax
    push dword [num]
    push sainum
    call printf
    add esp, 12

    mov ebx, 0 ; EXIT_SUCCESS
    mov eax, 1 ; exit()
    int 0x80

section .data
entnum: db "Digite um numero inteiro e positivo: ",0
fmtent: db "%u",0
sainum: db "O fatorial de %u eh %u",10,0

section .bss
num: resd 1
