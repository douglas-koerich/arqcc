%include "io.inc"

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    ; printf("Digite o total de segundos: ");
    PRINT_STRING msg_total

    ; scanf("%d", &total);
    GET_DEC 4, total

    ; hora = total / 3600;
    mov ecx, 3600 ; precisa carregar o divisor num registrador
                  ; porque DIV nao aceita divisao por constante
    mov eax, [total]
    mov edx, 0    ; se nao zerar o EDX, o conteudo eventual dele
                  ; vai ser usado como a parte superior do numero
                  ; de 64 bits na operacao DIV abaixo
    div ecx       ; EDX:EAX (0:7248) / ECX (3600)

    mov [hora], eax ; quociente foi para EAX

    ; total = total % 3600;
    mov [total], edx ; EDX jah contem o resto vindo da operacao DIV acima

    ; minuto = total / 60;
    mov ecx, 60
    mov eax, [total]
    mov edx, 0
    div ecx

    mov [minuto], eax

    ; segundo = total % 60;
    mov [segundo], edx

    ; printf("%02d:%02d:%02d\n", hora, minuto, segundo);
    PRINT_DEC 4, hora
    NEWLINE
    PRINT_DEC 4, minuto
    NEWLINE
    PRINT_DEC 4, segundo

    ; Saida do programa
    mov ebx, 0
    mov eax, 1
    int 80h

section .data

msg_total:  db "Digite o total de segundos: "

section .bss

total:      resd 1 ; reserva uma dword (32 bits) na memoria para variavel (global)
hora:       resd 1
minuto:     resd 1
segundo:    resd 1