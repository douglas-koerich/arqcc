section .text
    global main
    extern printf
    extern scanf

main:
    push msg_total
    call printf
    add esp, 4

    push total
    push percent_d
    call scanf
    add esp, 8

    mov ecx, 3600
    mov eax, [total] ; a ultima vez que acessamos a memoria neste programa-
                     ; -exemplo
    mov edx, 0
    div ecx

    mov ebx, eax     ; salva em EBX o valor jah calculado da hora (nao vai
                     ; ateh a memoria para escrever/salvar esse dado)

    mov eax, edx     ; atualiza EAX com o novo dividendo a ser usado (resto
                     ; das horas)
    mov ecx, 60
    mov edx, 0
    div ecx

    push edx
    push eax
    push ebx
    push msg_final
    call printf
    add esp, 16

    mov ebx, 0
    mov eax, 1
    int 80h

section .data

msg_total:  db "Digite o total de segundos: ",0
percent_d:  db "%d",0
msg_final:  db "%02d:%02d:%02d",10,0

section .bss

total: resd 1 ; ainda necessario por conta do uso de scanf