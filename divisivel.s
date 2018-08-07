; unsigned dividendo, divisor;    // variaveis globais
; int main() {
;   printf("Digite o dividendo: ");
;   scanf("%u", &dividendo);
;   printf("Digite o divisor: ");
;   scanf("%u", &divisor);
;   if (dividendo % divisor == 0) {
;       printf("O dividendo eh divisivel pelo divisor.\n");
;   } else {
;       printf("O dividendo NAO eh divisivel pelo divisor.\n");
;   }
;   return 0;
; }

section .text
    global main
    extern printf
    extern scanf
main:
    push    msg_dividendo
    call    printf
    add     esp, 4  ; 4 eh o tamanho de um endereco na arquitetura IA-32 do x86
    push    dividendo
    push    tipo_controle
    call    scanf
    add     esp, 8  ; foram empilhados 2 enderecos de 32 bits (2 x 4 bytes)

    push    msg_divisor
    call    printf
    add     esp, 4
    push    divisor
    push    tipo_controle
    call    scanf
    add     esp, 8

    ; dividendo % divisor
    xor     edx, edx    ; equivalente a mov edx, 0, mas mais rapido
    mov     eax, [dividendo]
    mov     ebx, [divisor]
    div     ebx

    cmp     edx, 0      ; EDX tem o resto da divisao inteira
    je      exibe_sim   ; se for igual (edx=0), faz um GOTO pra exibe_sim

    ; else ...
    push    msg_nao_eh_div
    jmp     print       ; para nao entrar pelo caso do 'if' rotulado abaixo

exibe_sim:
    ; if ...
    push    msg_eh_divisivel
    ; continua pela instrucao abaixo...

print:
    call    printf
    add     esp, 4

    mov     ebx, EXIT_SUCCESS
    mov     eax, EXIT_SYSCALL
    int     80h

section .data
msg_dividendo:      db  'Digite o dividendo: ',0
msg_divisor:        db  'Digite o divisor: ',0
tipo_controle:      db  '%u',0
msg_eh_divisivel:   db  'O dividendo eh divisivel pelo divisor.',10,0
msg_nao_eh_div:     db  'O dividendo NAO eh divisivel pelo divisor.',10,0

; Nao sao dados, sao pseudoinstrucoes para definicao de constantes que sao
; substituidas pelo montador durante a traducao para a linguagem de maquina
EXIT_SUCCESS:       equ 0
EXIT_SYSCALL:       equ 1

section .bss
dividendo:          resd    1
divisor:            resd    1
