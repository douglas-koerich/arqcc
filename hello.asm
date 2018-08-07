section .data   ; secao de dados do programa (variaveis GLOBAIS INICIALIZADAS)
frase:  db  'Meu primeiro programa em Assembly!',10,0 ; Uma constante string terminada com \n\0 (10,0)

section .bss    ; outra secao de dados (variaveis globais NAO inicializadas)

section .text
    global  main    ; ao inves da funcao main() estar em um codigo-fonte C, vou defini-la aqui
    extern  printf  ; todo ROTULO externo deve ser "importado" usando uma linha como esta

main:                   ; "main" eh o ROTULO do endereco onde se inicia o meu programa
    mov     eax, frase  ; carrega o ENDERECO (rotulo) da constante string num registrador
    push    eax         ; copia o conteudo do registrador (frase) para a pilha (area de transferencia entre rotinas)
    call    printf      ; desvia/chama (para) o rotulo (funcao) "printf"
    add     esp, 4      ; limpa a area utilizada na pilha

    mov     ebx, 0      ; 0 = EXIT_SUCCESS
    mov     eax, 1      ; 1 = EXIT (chamada de sistema para sair do programa)
    int     80h         ; interrupcao do Linux pra executar a chamada de sistema (system call)

