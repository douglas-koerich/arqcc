section .text
    global main
    extern printf
    extern scanf

main:
    ; printf("Digite o total de segundos: ");
    push msg_total
    call printf
    add esp, 4

    ; scanf("%d", &total);
    push total  ; rotulo 'total' em assembly <==> &total em C
    push percent_d
    call scanf
    add esp, 8  ; 4 bytes de 'total' + 4 bytes de 'percent_d'

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
    push dword [segundo]
    push dword [minuto]
    push dword [hora]
    push msg_final
    call printf
    add esp, 16 ; 4 bytes de cada push acima... 

    ; Saida do programa
    mov ebx, 0
    mov eax, 1
    int 80h

section .data

msg_total:  db "Digite o total de segundos: ",0
percent_d:  db "%d",0
msg_final:  db "%02d:%02d:%02d",10,0

section .bss

total:      resd 1 ; reserva uma dword (32 bits) na memoria para variavel (global)
hora:       resd 1
minuto:     resd 1
segundo:    resd 1