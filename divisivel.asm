section .text
    global main
    extern printf
    extern scanf

main:
    push pede_n1
    call printf
    add esp, 4

    push num1 ; empilhando o rotulo, i.e., o *endereco* (&num1 no scanf!)
    push form_hu
    call scanf
    add esp, 4
    
    push pede_n2
    call printf
    add esp, 4

    push num2
    push form_hu
    call scanf
    add esp, 4

    ; Verifica se o num1 eh divisivel pelo num2 (resto da divisao eh 0)

    ; Na instrucao DIV o dividendo (aquele que vai ser dividido) deve estar
    ; previamente armazenado no registrador Acumulador (AL/AX/EAX)
    mov ax, word [num1] ; copia os 16 bits em num1 para o registrador AX

    ; Na operacao de divisao por um numero de 16 bits, parte-se do principio
    ; que o divisor tem um "tamanho" (em bits) maior do que 32 bits; ora, ao
    ; usar registradores de 16 bits (como o AX), a instrucao DIV considera
    ; que os "outros 16 bits" desse divisor estao no DX.
    ; Porem, como em nosso caso tanto o dividendo (que trouxemos de num1 para AX)
    ; quanto o divisor (que ainda estah em num2) tem apenas 16 bits.
    ; Para que a instrucao DIV nao ache que o "lixo" que esteja em DX faca
    ; parte do dividendo (junto com num1), vamos zerar DX
    mov dx, 0 ; xor dx, dx --> instrucao XOR (ou-exclusivo bit-a-bit)

    ; Agora, o par DX:AX tem 0:num1, e eh isso que vai ser usado como dividendo
    ; pela instrucao DIV

    ; O divisor eh passado para a instrucao DIV
    div word [num2]

    cmp dx, 0 ; compara o valor em DX com 0
    je eh_sim ; salte se "eh, sim, divisivel" (DX igual a 0)

    ; Continua pela proxima se nao eh divisivel
    push res_nao
    jmp imprime

eh_sim:
    push res_sim

imprime:
    call printf
    add esp, 4

    ; Terminando o programa da forma como jah sabemos...
    mov eax, 1
    mov ebx, 0
    int 0x80

section .data
pede_n1: db "Digite o primeiro numero: ",0
pede_n2: db "Digite o outro numero: ",0
form_hu: db "%hu",0
res_sim: db "O primeiro numero eh divisivel pelo segundo",10,0
res_nao: db "O primeiro numero NAO eh divisivel pelo segundo",10,0

section .bss
num1: resw 1 ; reserva de memoria para um valor de 16 bits/"word" (short int)
num2: resw 1
