section .text               ; codigo
    global  _start          ; publica o simbolo _start para o linker
_start:                     ; endereco de entrada do programa (em qualquer linguagem)
    mov     ebx, STDOUT     ; a chamada sys_write do Linux requer que o "arquivo"-destino esteja em EBX
    mov     ecx, var_str    ; em ECX deve ser posto o ENDERECO inicial (=rotulo "var_str") dos bytes a serem impressos
    mov     edx, TAMANHO    ; deduzido pela diferenca entre dois rotulos adjacentes (var_str e TAMANHO - v. abaixo)
    mov     eax, SYS_WRITE  ; codigo da chamada de sistema
    int     80h             ; ativa interrupcao do sistema operacional para tratamento da system call

    mov     ebx, SUCCESS
    mov     eax, SYS_EXIT
    int     10000000b       ; 80h em binario

section .data               ; variaveis GLOBAIS inicializadas e CONSTANTES
var_ch:     db  'A'         ; char var_ch = 'A'; (db = byte - 8 bits)
var_str:    db  'Ola!',10,0 ; char var_str[] = "Ola!\n"; (10,0 indica \n mais \0 - terminador nulo)
TAMANHO:    equ $-var_str   ; $=endereco atual, entao TAMANHO=(endereco atual - endereco "var_str")=comprimento da string "Ola!"
var_short:  dw  100         ; short int var_short = 100; (dw = word - 16 bits)
var_long:   dd  262144      ; long int var_long = 262144; (dd = double-word - 32 bits)
; ainda estou no .data
SYS_WRITE:  equ 4           ; codigo da chamada de sistema do Linux que imprime em um arquivo
STDOUT:     equ 1           ; descritor de arquivo do video em Linux
SYS_EXIT:   equ 1           ; codigo da system call que sai do programa
SUCCESS:    equ 0           ; codigo de retorno com sucesso (EXIT_SUCCESS)

section .bss                ; variaveis GLOBAIS NAO inicializadas (apenas reserva)
var_ch1:    resb 1          ; char var_ch1; (apenas reserva um byte - resb 1)
MAX_STR1:   equ 10          ; #define MAX_STR1 10
var_str1:   resb MAX_STR1   ; char var_str1[MAX_STR1];
var_sht1:   resw 1          ; short int var_sht1;
var_lng1:   resd 1          ; long int var_lng1;

