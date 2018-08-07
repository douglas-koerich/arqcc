%include "io.inc"

section .data

section .bss

section .text
    global CMAIN

;int main(void) {
;    int i;
;    for (i=1; i<=10; ++i) {
;        printf("%d\n", i);
;    }
;    return 0;
;}

CMAIN:
    mov     ebp, esp; for correct debugging
    mov     eax, 1  ; inicializa EAX com o primeiro valor a ser impresso <=> int i=1;
    mov     ecx, 10 ; numero de vezes que o laco serah executado

inicio:
    PRINT_DEC 4, eax
    jmp linha    ; preciso desviar do 'xunxo' que eh usado somente quando voltando do LOOP
    
xunxo:    ; atingivel por LOOP
    jmp inicio    ; o unico proposito do 'xunxo' eh alcancar o endereco 'inicio'
    
linha:
    NEWLINE

    inc     eax     ; incrementa o valor de EAX (equivalente ao ++i no laco for)
;    loop    inicio  ; volta para o rotulo 'inicio' se ECX > 0 (uso implicito do ECX pela instrucao LOOP

    ; Como a macro NEWLINE inseriu uma serie de instrucoes entre 'inicio' a LOOP, a distancia
    ; que a instrucao LOOP consegue indicar nao eh mais suficiente pra atingir 'inicio'; precisamos
    ; usar um endereco a uma distancia menor -> xunxo
    loop    xunxo
            
    ; Quando ECX = 0, nao volta para 'inicio', continua o programa (que agora vai terminar))
    mov     eax, 0
    ret
