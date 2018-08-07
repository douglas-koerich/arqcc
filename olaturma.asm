.386					; conjunto de instrucoes da IA-32 (i386)
.model flat, stdcall	; enderecos de memoria sem segmentacao
option casemap:none		; diferencia maiusc/minusculas

include \masm32\include\windows.inc		; definicoes, etc.
include \masm32\include\kernel32.inc

includelib \masm32\lib\kernel32.lib		; funcoes Win32

.data					; dados inicializados
MESSAGE	db	'Welcome to assembly programming',10,0

.data?					; dados nao inicializados (.bss)

.code
main:
	invoke	GetStdHandle, STD_OUTPUT_HANDLE
	invoke	WriteConsole, eax, addr MESSAGE, sizeof MESSAGE, ebx, NULL
	invoke	ExitProcess, 0
end main

