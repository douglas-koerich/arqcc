section .data
mensagem:	db	'Hello, world!',10	; <=> char* mensagem = "Hello, world!\n";
tamanho:	equ	$-mensagem			; <=> #define tamanho ... (no. de bytes da mensagem)

section .text
	global	_start
_start:
									; write(int fd, const void *buf, size_t count);
									; write(stdout, mensagem, tamanho);
	mov	eax, 4						; numero da chamada de sistema (4 = write)
	mov	ebx, 1						; numero do arquivo onde escrever (fd=1 : stdout/tela)
	mov ecx, mensagem				; endereco de memoria da origem (buf=mensagem)
	mov edx, tamanho				; numero de bytes a escrever (count=tamanho)
	int 80h							; chamada ao sistema operacional (Linux)

									; exit(EXIT_SUCCESS);
	mov eax, 1						; numero da chamada de sistema (1 = exit)
	mov ebx, 0						; 0=EXIT_SUCCESS
	int 80h							; chama outra vez o sistema operacional

