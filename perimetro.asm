; section .bss
; vetor:  resd    1   ; ponteiro para o vetor alocado dinamicamente
; lados:  resd    1
;
; section .data
; soma:   dd      0   ; valor inicial da variavel 'soma'
; peden:  db      'Digite o numero de lados que serao informados: ',0
; pedel:  db      'Digite o valor do novo lado: ',0
; exibes: db      'O perimetro desse poligono eh %d.',10,0
; fscan:  db      '%d',0

section .text
    global perimetro
;     global main
;     extern printf
;     extern scanf
;     extern malloc
;     extern free
;
; %macro      IMPRIME 1   ; o numero 1 indica que a macro tem apenas um argumento
;     push    %1          ; usa o parametro da macro aqui (textualmente)
;     call    printf
;     add     esp, 4
; %endmacro
;
; %macro      LE 2    ; o numero 2 indica que a macro requer dois argumentos
;     push    %2
;     push    %1
;     call    scanf
;     add     esp, 8
; %endmacro
;
; main:
;     ; push    peden
;     ; call    printf
;     ; add     esp, 4
;     IMPRIME peden
;
;     ; push    lados
;     ; push    fscan
;     ; call    scanf
;     ; add     esp, 8
;     LE      fscan, lados    ; fscan = %1, lados = %2 na macro
;
;     mov     eax, dword [lados]
;     mov     ebx, 4  ; sizeof(int) = 4
;     mul     ebx
;     push    eax
;     call    malloc
;     add     esp, 4
;     mov     dword [vetor], eax    ; vetor = retorno do malloc (vindo pelo EAX)
;
;     mov     edi, eax    ; inicializa registrador de destino com o mesmo endereco
;     mov     ecx, dword [lados]
; lacop:
;     push    ecx
;     push    edi     ; para salvar os registradores que serao alterados por printf/scanf
;     ; push    pedel
;     ; call    printf
;     ; add     esp, 4
;     IMPRIME pedel
;
;     pop     edi     ; recupera o registrador EDI deixando ECX salvo no topo da pilha
;     push    edi     ; salva o EDI novamente (por conta da alteracao por scanf)
;
;     ; push    edi     ; empilha de novo, dessa vez porque eh o segundo parametro do scanf
;     ; push    fscan
;     ; call    scanf
;     ; add     esp, 8
;     LE      fscan, edi
;
;     pop     edi     ; recupera os registradores para poder rodar o laco (que precisa do ECX)
;     pop     ecx
;
;     add     edi, 4  ; adianta registrador para o endereco do proximo inteiro no 'vetor'
;     loop    lacop
;
;     ; mov     esi, dword [vetor]
;     ; mov     ecx, dword [lados]
;     ; mov     eax, dword [soma]   ; espera-se que seja 0
; ; lacos:
; ;     mov     edx, dword [esi]
; ;     add     eax, edx
; ;     add     esi, 4      ; vai para o proximo inteiro
; ;     loop    lacos
;
;     push    dword [lados]
;     push    dword [vetor]   ; passa o valor do ponteiro (endereco do vetor)
;     call    perimetro
;     add     esp, 8
;     mov     dword [soma], eax
;
;     push    dword [soma]
;     push    exibes
;     call    printf
;     add     esp, 8
;
;     push    dword [vetor]   ; empilha o endereco salvo em 'vetor'
;     call    free
;     add     esp, 4
;
;     xor     ebx, ebx
;     mov     eax, 1
;     int     80h

perimetro:
    push    ebp         ; salva a base/referencia do quadro de funcao anterior
    mov     ebp, esp    ; marca posicao da nova base/referencia (DESTA funcao)

    sub     esp, 4      ; variavel local 's' (acumulador da soma)

    ; Em excecao de EAX e EDX que sao por convencao usados para o retorno de
    ; sub-rotinas, quaisquer outros registradores que forem alterados precisam
    ; ter seus valores preservados na pilha
    ; IMPORTANTE (pra facilitar): faca isso DEPOIS de reservar a pilha para
    ; TODAS as suas variaveis locais desta sub-rotina
    push    ecx
    push    esi

    mov     dword [ebp-4], 0    ; variavel local inicializada com 0 (como em perimetro.c)

    mov     esi, dword [ebp+8]  ; inicializa registrador de indice com o endereco do vetor passado na pilha
    mov     ecx, dword [ebp+12] ; inicializo registrador contador com o numero de lados passado na pilha

lacos:
    mov     edx, dword [esi]
    mov     eax, dword [ebp-4]  ; traz o valor atualizado de 's' para EAX
    add     eax, edx
    add     esi, 4              ; vai para o proximo inteiro
    mov     dword [ebp-4], eax  ; atualiza a variavel 's' com a nova soma
    loop    lacos

    mov     eax, dword [ebp-4]  ; retorno sempre vem no registrador EAX

    ; Restaura os registradores como vieram da funcao chamadora
    pop     esi
    pop     ecx

    add     esp, 4      ; destroi a (libera pilha da) variavel local 's'

    pop     ebp         ; restaura base da funcao anterior
    ret                 ; retorna para a proxima instrucao depois do CALL
