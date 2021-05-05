%include "io.inc"

section .data

msg:    db "Conteudo do vetor",0
espaco: db 0x20

section .bss

MAX:    equ 10

; short vetor1[MAX], vetor2[MAX];
vetor1: resw MAX
vetor2: resw MAX

section .text
global CMAIN

; int main(void) {
CMAIN:
    mov ebp, esp; for correct debugging
    ; int i, x;
    mov ecx, MAX

    ; char x = 100;
    mov ax, 100
    
    mov ebx, vetor1
    mov edi, 0
    
    ; for (i = 0; i < MAX; ++i, ++x) {
    
repete_atribuicao:
    ;   vetor1[i] = x;
    mov [ebx+edi], ax
    
    add edi, 2 ; ++i -> incremento de 2 bytes na memoria
    inc ax     ; ++x
    ; }
    loop repete_atribuicao
    
    mov ecx, MAX
    mov esi, vetor1
    mov edi, vetor2
    
repete_copia:
    cld
    rep movsw
    
    PRINT_STRING msg
    NEWLINE
    
    ; for (i = 0; i < MAX; ++i)
    ;   printf("%hd ", vetor2[i]);
    mov ecx, MAX
    mov ebx, vetor2
    mov esi, 0
repete_impressao:
    PRINT_DEC 2, [ebx+esi]
    add esi, 2 ; vai para a proxima word (16 bits) na memoria (no vetor)

    ; --- TRECHO INCLUIDO APENAS PARA RESOLVER A RESTRICAO DE SALTO DO LOOP ---
    jmp imprime_espaco
salto_proximo:
    jmp repete_impressao ;
imprime_espaco:
    ; --- FIM DO TRECHO DE CONTORNO ---

    PRINT_CHAR [espaco]
    loop salto_proximo
    NEWLINE
    
    ; return 0;
    mov ebx, 0
    mov eax, 1
    int 80h
; }
