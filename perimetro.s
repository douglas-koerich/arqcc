section .bss
vetor:  resd    1   ; ponteiro para o vetor alocado dinamicamente
lados:  resd    1

section .data
soma:   dd      0   ; valor inicial da variavel 'soma'
peden:  db      'Digite o numero de lados que serao informados: ',0
pedel:  db      'Digite o valor do novo lado: ',0
exibes: db      'O perimetro desse poligono eh %d.',10,0
fscan:  db      '%d',0

section .text
    global main
    extern printf
    extern scanf
    extern malloc
    extern free

%macro      IMPRIME 1   ; o numero 1 indica que a macro tem apenas um argumento
    push    %1          ; usa o parametro da macro aqui (textualmente)
    call    printf
    add     esp, 4
%endmacro

%macro      LE 2    ; o numero 2 indica que a macro requer dois argumentos
    push    %2
    push    %1
    call    scanf
    add     esp, 8
%endmacro

main:
    ; push    peden
    ; call    printf
    ; add     esp, 4
    IMPRIME peden

    ; push    lados
    ; push    fscan
    ; call    scanf
    ; add     esp, 8
    LE      fscan, lados    ; fscan = %1, lados = %2 na macro

    mov     eax, dword [lados]
    mov     ebx, 4  ; sizeof(int) = 4
    mul     ebx
    push    eax
    call    malloc
    add     esp, 4
    mov     dword [vetor], eax    ; vetor = retorno do malloc (vindo pelo EAX)

    mov     edi, eax    ; inicializa registrador de destino com o mesmo endereco
    mov     ecx, dword [lados]
lacop:
    push    ecx
    push    edi     ; para salvar os registradores que serao alterados por printf/scanf
    ; push    pedel
    ; call    printf
    ; add     esp, 4
    IMPRIME pedel

    pop     edi     ; recupera o registrador EDI deixando ECX salvo no topo da pilha
    push    edi     ; salva o EDI novamente (por conta da alteracao por scanf)

    ; push    edi     ; empilha de novo, dessa vez porque eh o segundo parametro do scanf
    ; push    fscan
    ; call    scanf
    ; add     esp, 8
    LE      fscan, edi

    pop     edi     ; recupera os registradores para poder rodar o laco (que precisa do ECX)
    pop     ecx

    add     edi, 4  ; adianta registrador para o endereco do proximo inteiro no 'vetor'
    loop    lacop

    mov     esi, dword [vetor]
    mov     ecx, dword [lados]
    mov     eax, dword [soma]   ; espera-se que seja 0
lacos:
    mov     edx, dword [esi]
    add     eax, edx
    add     esi, 4      ; vai para o proximo inteiro
    loop    lacos
    mov     dword [soma], eax

    push    dword [soma]
    push    exibes
    call    printf
    add     esp, 8

    push    dword [vetor]   ; empilha o endereco salvo em 'vetor'
    call    free
    add     esp, 4

    xor     ebx, ebx
    mov     eax, 1
    int     80h
