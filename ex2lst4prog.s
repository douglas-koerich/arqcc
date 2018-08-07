;unsigned qtos_numeros;
;unsigned menor;
;unsigned maior;
;unsigned media;
;unsigned numero;

;int main(void) {
;    printf("Digite quantos numeros vai ler: ");
;    scanf("%u", &qtos_numeros);

;    int n;
;    media = 0;
;    // for (n=1; n<=qtos_numeros; ++n) {
;    for (n=qtos_numeros; n>0; --n) {
;        printf("Digite o proximo numero: ");
;        scanf("%u", &numero);

;        if (n == qtos_numeros) {
;            maior = menor = numero;
;        } else {
;            if (numero > maior) {
;                maior = numero;
;            }
;            if (numero < menor) {
;                menor = numero;
;            }
;        }
;        media += numero;
;    }
;    media = media / qtos_numeros;
;    printf("Maior = %u, menor = %u, media = %u\n", maior, menor, media);
;    return EXIT_SUCCESS;
;}

section .data
msg1:   db 'Digite quantos numeros vai ler: ',0
msg2:   db 'Digite o proximo numero: ',0
format: db '%u',0
msg3:   db 'Maior = %u, menor = %u, media = %u',10,0

section .bss
qtos_numeros: resd 1
menor:  resd 1
maior:  resd 1
media:  resd 1
numero: resd 1


section .text
    global main
    extern printf
    extern scanf

main:
    push msg1
    call printf
    add esp, 4

    push qtos_numeros
    push format
    call scanf
    add esp, 8

    mov dword [media], 0
    mov ecx, dword [qtos_numeros]
inicio:
    ; inicio do bloco do laco for

    push ecx    ; salva o valor do contador na pilha,
                ; pois ECX serah alterado por printf com
                ; absoluta certeza...
    push msg2
    call printf
    add esp, 4

    push numero
    push format
    call scanf  ; pede o novo numero
    add esp, 8
    
    pop ecx     ; depois de chamar printf e scanf que certamente
                ; alteraram o valor de ecx, recupero o valor da
                ; pilha pondo-o de volta no mesmo registrador
                ; (para ser usado por 'loop')

    mov edx, dword [qtos_numeros]
    cmp ecx, edx    ; verifica se eh a primeira passagem do laco
    je primeiro_round

    ; else
    ; cmp dword [numero], dword [maior] (nao eh possivel comparar dois operandos de memoria)
    mov eax, dword [numero]
    mov ebx, dword [maior]
    cmp eax, ebx    ; numero (em EAX) > maior (em EBX)?
    ja num_maior

    mov ebx, dword [menor]
    cmp eax, ebx    ; numero (em EAX) < menor (em EBX)?
    jb num_menor

    jmp soma_media  ; nenhum dos dois, pula pra somar na media

num_maior:
    mov dword [maior], eax  ; maior = EAX (que contem o numero)
    jmp soma_media

num_menor:
    mov dword [menor], eax  ; menor = EAX (que contem o numero)
    jmp soma_media

primeiro_round: ; if (...)
    ; mov dword [maior], dword [numero] (nao eh possivel ler dois operandos de memoria)
    mov eax, dword [numero]
    mov dword [maior], eax
    mov dword [menor], eax

soma_media:
    mov ebx, dword [media]
    add ebx, eax ; media (em EBX) += numero (em EAX)
    mov dword [media], ebx

    loop inicio ; testa ECX > 0, decrementando-o

    ; esta proxima instrucao eh a seguinte apos o laco 'for'
    xor edx, edx
    mov eax, dword [media]
    mov ebx, dword [qtos_numeros]
    div ebx
    mov dword [media], eax

    push dword [media]
    push dword [menor]
    push dword [maior]
    push msg3
    call printf
    add esp, 16

    mov ebx, 0
    mov eax, 1
    int 80h 
