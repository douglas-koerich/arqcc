; Secao destinada as instrucoes do programa
; (parte da memoria alocada para codigo)
section .text
    global _start   ; publica o rotulo '_start' para o linker
_start:
    mov eax, 4      ; carrega o numero da system call sys_write
    mov ebx, 1      ; carrega o fd (file-descriptor) do stdout
    mov ecx, msg    ; carrega o endereco da mensagem na memoria
    mov edx, 22     ; carrega o numero de caracteres que serao escritos
    int 80h         ; executa a system call (write)

    mov eax, 1      ; carrega o numero da system call sys_exit
    mov ebx, 0      ; carrega o valor de retorno da saida do programa
    int 80h         ; executa a system call (exit)

; Secao dos dados constantes e "variaveis" globais inicializadas
section .data
msg:    db  'Meu primeiro programa',10  ; o valor 10 eh o codigo ASCII do \n

; Secao das "variaveis" globais nao inicializadas
section .bss
