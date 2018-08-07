section .data
var1:   dq  2.71828                     ; declara um double (8 bytes) contendo a constante 'e'
prmpt:  db  'Digite o valor de pi: ', 0
fmt:    db  '%lf'                       ; para o scanf() continua sendo necessario usar %lf, ok?!
msg1:   db  'e = %f',10,0               ; impressao da variavel inicializada
msg2:   db  'pi = %f',10,0              ; impressao de pi lido pelo scanf()

section .bss
var2:   resq    1                       ; resb/byte; resw/short; resd/long; resq/long-long (8 bytes)

section .text
    extern scanf
    extern printf
    global main

main:
    push    dword [var1+4]  ; Olha soh... como var1 tem 8 bytes, e PUSH soh consegue empilhar 2 ou
                            ; 4 bytes, entao preciso empilhar os 4 bytes menos significativos...
    push    dword [var1]    ; ... e depois empilhar os 4 bytes mais significativos de var1
    push    msg1
    call    printf
    add     esp, 12

    push    prmpt
    call    printf
    add     esp, 4

    push    var2            ; Note que aqui eh um PUSH soh, porque estou empilhando o /endereco/,
                            ; que tem 4 bytes, e nao o /valor/ que tem 8 bytes
    push    fmt
    call    scanf
    add     esp, 8

    push    dword [var2+4]
    push    dword [var2]
    push    msg2
    call    printf
    add     esp, 12

    mov     ebx, 0
    mov     eax, 1
    int     80h

