section .data
; #define TAMANHO 10
TAMANHO: equ 10
str_orig: db 'Este eh o vetor original: ',0
str_dobr: db 'Este eh o vetor dobrado: ',0
str_num:  db '%d ',0
str_CR:   db '',10,0 ; "\n"

section .bss
vetor_a:  resd  TAMANHO ; poderia usar (resd 10) se nao houvesse
                        ; definido um identificador para 10
vetor_b:  resd  TAMANHO

section .text

%macro PRINT_NUM 1
    push    %1
    push    str_num
    call    printf
    add     esp, 8
%endmacro

    global  main
    extern  printf
    extern  rand ; neste programa toda vez a mesma sequencia serah gerada

main:
    ; for (i=0; i<TAMANHO; ++i) vetor[i] = rand();
    mov     ecx, 0          ; ECX serah o registrador de controle do laco (i)
    mov     ebx, vetor_a    ; EBX = vetor_a, ou EBX = &vetor_a[0]
    mov     edi, 0          ; EDI tem o //deslocamento em BYTES//

gera_num:
    pusha   ; salva TODOS os registradores (ECX, EBX, EDI, etc.)
    call    rand                    ; nao ha PUSH anterior pq nao ha parametros (nem ADD depois)
    popa    ; recupera TODOS os registradores
    mov     dword [ebx+edi], eax    ; *(vetor_a + edi) = eax
    add     edi, 4          ; soma ao EDI o deslocamento //EM BYTES!!!// necessario: SIZEOF(int)
    inc     ecx
    cmp     ecx, TAMANHO
    jb      gera_num

    push    str_orig
    call    printf

    ; Novo percurso no vetor a
    mov     ecx, TAMANHO
    mov     ebx, vetor_a    ; EBX deve ter sido usado pelo printf...
    mov     esi, 0

imprime_num:
    pusha   ; salva TODOS os registradores (ECX, EBX, ESI, etc.)
    PRINT_NUM   dword [ebx+esi] ; a chamada de printf vai usar os registradores
    popa    ; recupera TODOS os registradores
    add     esi, 4 ; esi += sizeof(int)
    loop    imprime_num ; decrementa ECX e se for maior que zero volta ao inicio

    push    str_CR  ; printf("\n");
    call    printf
    add     esp, 4

    mov     ebx, 0
    mov     eax, 1
    int     80h

