; int num;
; int main() {
;   printf("Digite um numero: ");
;   scanf("%d", &num);
;   if (num % 2 == 0) {
;       printf("O numero eh par.\n");
;   } else {
;       printf("O numero eh impar.\n");
;   }
;   return 0;
; }

; Secao destinada ahs instrucoes do modulo em assembly
section .text
    global main     ; um rotulo conhecido por outros modulos
    extern printf   ; um rotulo de outro modulo que eu uso
    extern scanf

main:   ; rotulo de entrada do programa
    push    str_entrada     ; empilha o rotulo/endereco da string
    call    printf          ; chama o "rotulo"/endereco da funcao printf
    add     esp, 4          ; desconsidera a string na pilha

    push    num             ; empilha o rotulo/ENDERECO da variavel (&num)
    push    str_tipo        ; empilha o rotulo/endereco da string do tipo
    call    scanf           ; chama scanf
    add     esp, 8          ; desconsidera o que foi empilhado

    mov     eax, [num]      ; traz o valor da variavel global da MEMORIA para um registrador
    xor     edx, edx        ; zera(?) o valor do registrador
    mov     ebx, 2          ; carrega no registrador o valor da constante
    div     ebx             ; divide o par EDX:EAX (operando IMPLICITO) por EBX

    cmp     edx, 0          ; resto (que fica em EDX) eh zero?
    je      par             ; salta ("goto") para o rotulo/endereco 'par'
    push    str_eh_impar    ; empilha a string que vai ser impressa
    jmp     imprime         ; salta para a impressao
par:
    push    str_eh_par      ; empilha a string que vai ser impressa
imprime:
    call    printf          ; imprime a string empilhada
    add     esp, 4          ; descarta a string

    mov     ebx, 0          ; esse 0 eh o que vai ser retornado
    mov     eax, 1          ; o codigo 1 eh o numero da "system call" do Linux (exit)
    int     80h             ; chama a system call do SO

; Secao das constantes e variaveis GLOBAIS *inicializadas*
; (Exemplo: int x = 10;)
section .data
str_entrada:    db  'Digite um numero: ',0 ; uma C-string (terminada com nulo)
str_tipo:       db  '%d',0 ; nao esquecer do ,0 para que scanf ache o fim
str_eh_par:     db  'O numero eh par.',10,0 ; o 10 eh o codigo ASCII do \n ;-)
str_eh_impar:   db  'O numero eh impar.',10,0

; Secao das variaveis GLOBAIS *nao* inicializadas
; (Exemplo: int y;)
section .bss ; "Block Started by Symbol"
num:    resd    1 ; (res)erva 1 (d)ouble-word na memoria

