section .text
    global  main
    extern  printf
    extern  scanf
main:
    push    p_palavra
    call    printf
    add     esp, 4
    push    string  ; empilha o endereco do vetor (seu nome em C!)
    push    s_string
    call    scanf
    add     esp, 8

    push    p_caracter
    call    printf
    add     esp, 4
    push    c   ; empilha o endereco de c
    push    s_char
    call    scanf
    add     esp, 8

    mov     esi, string ; char* esi = string;
    and     dl, 0       ; achou = 0; usa um registrador de 8 bits para o flag 'achou'
                        ; ao inves de usar 'mov' zera o registrador com AND

    mov     ah, byte [c]    ; para fazer apenas uma leitura de memoria no endereco 'c'
compara:
    mov     al, byte [esi]  ; al (registrador-byte) = *esi;
    cmp     al, 0           ; al == '\0'?
    je      fim_laco

    cmp     al, ah
    je      achou
    inc     esi
    jmp     compara

achou:
    or      dl, 1       ; achou = 1; "liga" o bit menos significativo de dl com OR

fim_laco:
    cmp     dl, 1       ; achou == 1?
    je      encontrado
    push    r_n_achou
    jmp     imprime

encontrado:
    push    r_achou

imprime:
    call    printf
    add     esp, 4

    xor     ebx, ebx
    mov     eax, 1
    int     80h         ; exit(0);

section .data
MAX_STRING: equ 20      ; #define MAX_STRING 20
p_palavra:  db  'Digite uma palavra: ',0
p_caracter: db  'Digite um caractere: ',0
s_string:   db  ' %s',0
s_char:     db  ' %c',0
r_achou:    db  'Caractere encontrado!',10,0    ; com \n
r_n_achou:  db  'Caractere nao encontrado!',10,0

section .bss
string:     resb    MAX_STRING  ; char string[MAX_STRING];
c:          resb    1

;Vou usar registradores pra isso...
;i:          resd    1
;achou:      resd    1   ; programador perdulario que gasta 32 bits pra usar 1...
