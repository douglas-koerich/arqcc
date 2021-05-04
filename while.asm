section .text
    global main
    extern printf
    extern scanf

main:
    push msg_pedido
    call printf
    add esp, 4

    push numero
    push percent_d
    call scanf
    add esp, 8

    ; inicializacao do laco
    mov ecx, 1

teste:
    cmp ecx, 10
    ja fim_tabuada

    mov eax, [numero]
    mul ecx     ; salva o produto no par EDX:EAX

    ; TODA funcao/sub-rotina chamada tem potencial para alterar
    ; o conteudo dos registradores. Assim, antes de chamar 'printf'
    ; vamos EMPILHAR TODOS os registradores
    pushad ; (v. guia de referencia)

    ; printf("%2d x %2d = %3d\n", numero, contador, produto);
    push eax
    push ecx
    push dword [numero]
    push linha_tabuada
    call printf
    add esp, 16

    popad ; aqui nao se trata de "limpar" a area da pilha ocupada
          ; pelos registradores em PUSHAD, mas de realmente recupera-los

    inc ecx
    jmp teste

fim_tabuada:
    mov ebx, 0
    mov eax, 1
    int 80h

section .data

msg_pedido:     db "Digite o numero: ",0
percent_d:      db "%d",0
linha_tabuada:  db "%2d x %2d = %3d",10,0

section .bss

numero: resd 1