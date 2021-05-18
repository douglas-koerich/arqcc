section .text
    global fatorial

fatorial:
    push ebp
    mov ebp, esp
    ; sem variaveis locais, usa os proprios registradores
    push ebx
    push esi
    push edi

    ; unsigned f = 1;
    mov eax, 1

    ; for (i = x; i > 0; --i)
    mov ecx, [ebp+8] ; valor no primeiro parametro
    cmp ecx, 0
    je  retorno

repete:
    ;   f *= i;
    mul ecx
    loop repete

retorno:
    pop edi
    pop esi
    pop ebx

    mov esp, ebp
    pop ebp
    
    ret ; EAX contem o fatorial calculado (e retornado)
