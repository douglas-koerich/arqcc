; area de codigo do programa
section .text
    global  main    ; publica o rotulo main() como se fosse um programa em C
    extern  printf
    extern  scanf

main:   ; equivale ao ponto de entrada da funcao main() num programa em C
    push    msg_digite  ; poe na pilha o ENDERECO da string (diminui em 4 o ESP)
    call    printf
    add     esp, 4      ; volta o topo da pilha para a posicao original

    push    total       ; rotulo 'total' em Assembly equivale a '&total' em C
    push    cod_scanf   ; empilha do fim para o inicio dos parametros...
    call    scanf
    add     esp, 8      ; dessa vez tenho q devolver 8 bytes (dois enderecos)

    mov     edx, 0      ; zera a MSD (most-significant double-word) do dividendo
    mov     eax, [total]; '[total]' em Assembly equivale a '*total' em C
    mov     ebx, HORA_CHEIA ; a instrucao DIV nao aceita uma constante como Op
    div     ebx

    mov     ecx, eax    ; quociente eh salvo em ECX
    mov     eax, edx    ; resto eh copiado para EAX para proxima divisao
    xor     edx, edx    ; preferivel do que mov edx, 0 (mais rapido em ULA)
    mov     ebx, MIN_CHEIO
    div     ebx

    push    edx
    push    eax
    push    ecx
    push    msg_final
    call    printf
    add     esp, 16

    mov     ebx, 0
    mov     eax, 1
    int     80h

;-------------------------------------------------------------------------------
; area de constantes e outros dados inicializados
section .data

msg_digite: db 'Digite o total em segundos: ',0 ; nao esquecer o ,0 (equiv. \0)
msg_final:  db '%02d:%02d:%02d',10,0 ; aqui o ,10 significa usar o \n no final
cod_scanf:  db '%d',0
HORA_CHEIA: equ 3600 ; #define HORA_CHEIA 3600
MIN_CHEIO:  equ 60

;-------------------------------------------------------------------------------
; area de variaveis globais nao inicializadas
section .bss

; unsigned total;
total:  resd 1  ; REServa uma (1) Double-word (resd) para um numero de 32 bits
