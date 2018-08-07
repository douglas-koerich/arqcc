section .text
	global	func
func:
	push	ebp
	mov		ebp, esp
	mov		esi, [ebp+8]
	mov		eax, [ebp+12]
	mov		ebx, 4
	xor		edx, edx
	mul		ebx
	mov		ebx, eax
f1:
	sub		ebx, 4
	mov		ecx, [esi+ebx]
	xor		edx, edx
	mov		eax, 1
	cmp		ecx, 0
	je		f3
f2:
	mul		ecx
	loop	f2
f3:
	mov		dword [esi+ebx], eax
	cmp		ebx, 0
	jne		f1
	mov		eax, esi
	pop		ebp
	ret

