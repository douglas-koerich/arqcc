section .text

;------------------------------------------------------------------------------
	global	strlen_dk	; size_t strlen_dk(const char* s);
strlen_dk:
	push	ebp			; salva inicio de quadro da funcao chamadora
	mov		ebp, esp	; inicio de quadro desta funcao
	mov		esi, [ebp+8]; poe ESI no endereco de inicio da string-parametro
	xor		ecx, ecx	; zera o registrador (usa ECX porque lodsb usa EAX)
	cld					; sinaliza o flag de direcao para incrementar ESI
inicio_len_dk:
	; *** USO DA INSTRUCAO lodsb ***
	lodsb				; le um byte do endereco atual em ESI para EAX
	cmp		al, 0		; encontrou terminador nulo (0)?
	je		fim_len_dk
	inc		ecx			; conta mais um caracter
	jmp		inicio_len_dk
fim_len_dk:
	mov		eax, ecx	; retorna sempre pelo registrador EAX
	pop		ebp			; recupera inicio de quadro da funcao chamadora
	ret

;------------------------------------------------------------------------------
	global	strcpy_dk	; char* strcpy_dk(char* dest, const char* src);
strcpy_dk:
	push	ebp			; salva inicio de quadro da funcao chamadora
	mov		ebp, esp	; inicio de quadro desta funcao
	mov		esi, [ebp+12] ; poe ESI no endereco de inicio da string de origem
	mov		edi, [ebp+8]; poe EDI no endereco de inicio da string de destino
	cld					; sinaliza o flag de direcao para incrementar ESI e EDI
cpy_dk:
	; *** USO DA INSTRUCAO movsb ***
	movsb				; copia byte em ESI para byte em EDI
	cmp		byte [esi-1], 0 ; acabou de copiar o terminador nulo?
	jne		cpy_dk
	mov		eax, [ebp+8]; o prototipo original de C devolve o endereco destino
	pop		ebp			; recupera inicio de quadro da funcao chamadora
	ret

;------------------------------------------------------------------------------
	global	strcat_dk	; char* strcat_dk(char* dest, const char* src);
strcat_dk:
	push	ebp			; salva inicio de quadro da funcao chamadora
	mov		ebp, esp	; inicio de quadro desta funcao
	mov		esi, [ebp+12] ; poe ESI no endereco de inicio da string de origem
	mov		edi, [ebp+8]; poe EDI no endereco de inicio da string de destino
	xor		al, al		; vai procurar pelo terminador nulo
	cld					; sinaliza o flag de direcao para incrementar ESI e EDI
busca_cat_dk:
	; *** USO DA INSTRUCAO scasb ***
	scasb
	jne		busca_cat_dk
	dec		edi			; Volta EDI para o endereco onde achou o terminador
cat_dk:
	; *** USO DA INSTRUCAO movsb ***
	movsb				; copia byte em ESI para byte em EDI
	cmp		byte [esi-1], 0 ; acabou de copiar o terminador nulo?
	jne		cat_dk
	mov		eax, [ebp+8]; o prototipo original de C devolve o endereco destino
	pop		ebp			; recupera inicio de quadro da funcao chamadora
	ret

;------------------------------------------------------------------------------
	global	strcmp_dk	; int strcmp_dk(const char* s1, const char* s2);
strcmp_dk:
	push	ebp			; salva inicio de quadro da funcao chamadora
	mov		ebp, esp	; inicio de quadro desta funcao
	xor		eax, eax	; inicializa retorno como strings iguais (a confirmar)
	mov		esi, [ebp+12] ; poe ESI no endereco de inicio da string de origem
	mov		edi, [ebp+8]; poe EDI no endereco de inicio da string de destino
	cld					; sinaliza o flag de direcao para incrementar ESI e EDI
cmp_dk:
	; *** USO DA INSTRUCAO cmpsb ***
	cmpsb				; compara o byte em ESI com o byte em EDI
	jl		menor_dk	; o byte em ESI eh menor que o byte em EDI
	jg		maior_dk	; o byte em ESI eh maior que o byte em EDI
	cmp		byte [esi-1], 0 ; acabou de comparar o terminador nulo?
	je		fim_dk
	jmp		cmp_dk		; sao iguais, vai comparar os proximos bytes
menor_dk:
	mov		eax, 1		; 2a. string (ESI) eh menor, 1a. string (EDI) eh maior
	jmp		fim_dk
maior_dk:
	mov		eax, -1		; 2a. string (ESI) eh maior, 1a. string (EDI) em menor
fim_dk:
	pop		ebp
	ret

