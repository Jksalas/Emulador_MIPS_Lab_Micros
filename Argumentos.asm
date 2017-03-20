section .data
	m db 0

section .bss
	argc resb 8
	argPos resb 8

section .text
	global _start

_start:
	mov rax, 0
	mov r14, 0
	mov [argPos], rax

	pop rax
	mov [argc], rax

_printArgsLoop:
	mov r15, 1
	mov rax, [argPos]
	inc rax
	mov [argPos], rax
	pop rax

	cmp byte[m],0
	je seguir

loopLecturaArgumento:

	cmp byte[m], 1
	je argumento1
	cmp byte[m], 2
	je argumento2
	cmp byte[m], 3
	je argumento3
	cmp byte[m], 4
	je argumento4
	jmp seguir

;---------------ASIGNAR ARGUMENTOS A REGISTROS-------------

argumento1:
	DeterminarArgumento r8 ; Guardar en r8 el primer argumento
argumento2:
	DeterminarArgumento r9 ; Guardar en r9 el segundo argumento
argumento3:
	DeterminarArgumento r10; Guardar en r10 el tercer argumento
argumento4:
	DeterminarArgumento r11; Guardar en r11 el cuarto argumento

seguir:
	inc byte[m]
	mov rax, [argPos]
	mov rbx, [argc]
	cmp rax, rbx
	jne _printArgsLoop


; Se guarda en r8, r9, r10 y r11 los 
; argumentos de $a0, $a1, $a2 y $a3 
; respectivamente

	mov [reg4],r8
	mov [reg5],r9
	mov [reg6],r10
	mov [reg7],r11

_exit:
    mov eax, 1  
    mov ebx, 0 
    int 80h
