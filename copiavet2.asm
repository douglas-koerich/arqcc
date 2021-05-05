%include "io.inc"

section .data

msg:    db "Conteudo do vetor",0
espaco: db 0x20 ; codigo ASCII do espaco em branco

section .bss

; #define MAX 10
MAX:    equ 10

; char vetor1[MAX], vetor2[MAX];
vetor1: resb MAX ; resb 10
vetor2: resb MAX

section .text
global CMAIN

; int main(void) {
CMAIN:
    mov ebp, esp; for correct debugging
    ; int i;
    mov ecx, MAX ; para controle de laco, o ECX sempre eh DEcrementado

    ; char c = 'A';
    mov al, 'A'
    
    mov ebx, vetor1 ; poe em EBX o endereco de inicio do vetor1 na memoria
    mov edi, 0      ; registrador EDI usado como indice de deslocamento
                    ; dentro do vetor1
    
    ; for (i = 0; i < MAX; ++i, ++c) {
    
repete_atribuicao:
    ;   vetor1[i] = c;
    mov [ebx+edi], al
    
    inc edi ; ++i
    inc al  ; ++c
    ; }
    loop repete_atribuicao
    
    mov ecx, MAX
    mov esi, vetor1 ; armazena o endereco inicial de vetor1 (ESI usado como ponteiro)
    mov edi, vetor2 ; EDI serah usado como ponteiro dentro dos elementos de vetor2
    
    ; for (i = 0; i < MAX; ++i) {
    ;   // vetor2[i] = vetor1[i];
    ;   *(vetor2 + i) = *(vetor1 + i);
    cld       ; configura ESI e EDI para serem INcrementados por MOVSB
    rep movsb ; REPete a MOVimentacao de Byte do endereco em ESI para o endereco em EDI
    
    PRINT_STRING msg
    NEWLINE
    
    ; for (i = 0; i < MAX; ++i)
    ;   printf("%c ", vetor2[i]);
    mov ecx, MAX
    mov ebx, vetor2
    mov esi, 0
repete_impressao:
    PRINT_CHAR [ebx+esi]
    inc esi

    ; --- TRECHO INCLUIDO APENAS PARA RESOLVER A RESTRICAO DE SALTO DO LOOP ---
    jmp imprime_espaco
salto_proximo:  ; com as macros PRINT_CHAR, a distancia entre LOOP e o rotulo
                ; repete_impressao ficou maior que 128 (max. possivel para LOOP),
                ; entao colocamos um ponto intermediario de salto
    jmp repete_impressao ; "trampolim" pra chegar em repete_impressao
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
    
