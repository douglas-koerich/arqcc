; Elabore um programa em assembly que receba uma string do teclado e
; copie a string de entrada para uma string de saida.

section .data
MAX_STRING: equ 50  ; #define MAX_STRING 50
msg_in:     db  'Digite uma frase curta:',0
msg_out:    db  'A frase duplicada eh:',0

section .bss
str_src:    resb    MAX_STRING  ; char str_src[MAX_STRING];
str_dst:    resb    MAX_STRING

section .text
    extern  puts
    extern  gets
    extern  strlen
    global  main
main:
    push    msg_in
    call    puts
    add     esp, 4

    ; Leitura da string usando gets
    push    str_src
    call    gets
    add     esp, 4

    ; Chama strlen para calcular o comprimento da string de entrada
    push    str_src
    call    strlen
    add     esp, 4

    ; Como recupera o retorno de uma funcao??
    ; R.: O compilador C (e isso vale para outras linguagens de alto nivel)
    ; retorna o valor no registrador EAX
    mov     ecx, eax    ; EAX tem o numero de caracteres calculado por strlen()
    ;;;;;;;;;;;
    ; 1a. alteracao: nao vamos incluir a copia do terminador nulo no LOOP
    ; inc     ecx         ; para incluir na copia tambem o terminador nulo!
    ;;;;;;;;;;;

    mov     esi, str_src    ; ESI tem o endereco inicial da string de entrada
    mov     edi, str_dst    ; EDI tem o endereco inicial da string de saida

    ;;;;;;;;;;;
    ; 2a. alteracao: vamos trocar o laco por uma UNICA instrucao REP
    ;
;copia:
    ; Como MOV nao aceita que os dois operandos estejam na memoria, vou precisar
    ; de um registrador do tipo byte (AL, AH, BL, etc.) para usar como area de
    ; transferencia
    ;mov     al, [esi]   ; copia um byte (caracter) da string de origem para o
    ;                    ; registrador AL (8 bits inferiores de EAX)
    ;mov     [edi], al   ; transfere de AL para a string de destino
    ;inc     esi         ; incrementa o endereco que aponta para o caracter na string
    ;inc     edi
    ;loop    copia       ; repete enquanto nao termina o numero de caracteres
    rep movsb

    ;;;;;;;;;;;
    ; 1a. alteracao: vamos copiar o terminador nulo usando uma instrucao tipo string
    ;;;;;;;;;;;
    movsb               ; (sem operandos!) copia de ESI para EDI, incrementando ambos

    ; Imprime a string copiada
    push    str_dst
    call    puts
    add     esp, 4

    mov     ebx, 0
    mov     eax, 1
    int     0x80
