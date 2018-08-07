; inicio
;   declare lado_maior, lado_menor, perimetro : inteiro
;   leia lado_maior, lado_menor
;   perimetro <- 2*lado_maior + 2*lado_menor
;   escreva perimetro
; fim

section .text
    extern  printf      ; funcoes da biblioteca-padrao de C "emprestadas" por este programa
    extern  scanf
    global  main
main:
    ; printf("Digite o valor do lado maior: ");
    push    pede_maior  ; poe na pilha o ENDERECO da mensagem de prompt (acrescenta 4 bytes ao topo da pilha)
    call    printf
    add     esp, 4      ; volta o registrador de topo da pilha
    ; scanf("%d", &lado_maior);
    push    lado_maior  ; comeca empilhando o ultimo argumento; lembre-se que lado_maior eh um ENDERECO (ja eh o &)
    push    tipo_scanf  ; vai empilhando do ultimo para o primeiro...
    call    scanf
    add     esp, 8      ; como foram 2 (dois) enderecos empilhados, precisa voltar o topo da pilha em 8 bytes

    ; o mesmo codigo (conjunto de instrucoes) vai ser usado para o segundo prompt
    push    pede_menor
    call    printf
    add     esp, 4
    push    lado_menor
    push    tipo_scanf
    call    scanf
    add     esp, 8

    ; para executar a operacao aritmetica, eh melhor trazer das variaveis em memoria para os registradores
    mov     eax, [lado_maior]   ;   [lado_maior] = CONTEUDO no endereco/rotulo lado_maior
    mov     ecx, 2      ; A instrucao MUL nao aceita uma constante como 'fonte'
    mul     ecx         ; EAX estah implicito, a operacao eh EAX = EAX (lado maior) * ECX (2)
    mov     ebx, eax    ; salva o resultado parcial em EBX
    mov     eax, [lado_menor]
    mul     ecx         ; EAX = EAX (lado menor) * ECX (2)
    add     ebx, eax    ; EBX += EAX (resulta no perimetro, i.e., na soma das multiplicacoes)
    mov     [perimetro], ebx

    ; printf("O perimetro do retangulo vale %d.\n", perimetro);
    push    dword [perimetro]   ; instrui PUSH para pegar 4 bytes no conteudo do endereco "perimetro"
    push    resultado
    call    printf
    add     esp, 8

    mov     ebx, 0
    mov     eax, 1
    int     0x80

section .data
pede_maior: db  'Digite o valor do lado maior: ',0          ; mensagens dos printf's
pede_menor: db  'Agora, digite o lado menor: ',0
resultado:  db  'O perimetro do retangulo vale %d.',10,0
tipo_scanf: db  '%d',0                                      ; definicao de formato dos scanf's

section .bss
lado_maior: resd 1  ; int lado_maior;
lado_menor: resd 1  ; int lado_menor;
perimetro:  resd 1  ; int perimetro;

