;#################################################
;Impresión de mensajes de interración con usuario
;EL4313 - Laboratorio de Estructura de Microprocesadores
;#################################################

	

;--------------------Segmentos de datos----------------------
section .data
	uno: db "************************** Bienvenido al Emulador MIPS *************************", 0xa, 0xa
	uno_tamano: equ $-uno

	dos: db 0x1b,"[96m", "        EL-4313 - Lab Estructura de Microprocesadores", 0xa
	dos_tamano: equ $-dos
	
	tres: db 0x1b,"[96m", "        IS - 2017", 0xa
	tres_tamano: equ $-tres

	cuatro: db 0x1b,"[96m","        Buscando archivo ROM.txt", 0xa
	cuatro_tamano: equ $-cuatro

;------------------------- Segmento de codigo ---------------------

section .text
	global _start
	global _segunda
	global _tercera

_start:
	mov rax,1
	mov rdi,1
	mov rsi,uno
	mov rdx,uno_tamano
	syscall

	mov rax,1
	mov rdi,1
	mov rsi,dos
	mov rdx,dos_tamano
	syscall

	mov rax,1
	mov rdi,1
	mov rsi,tres
	mov rdx,tres_tamano
	syscall

	mov rax,1
	mov rdi,1
	mov rsi,cuatro
	mov rdx,cuatro_tamano
	

_segunda:
	syscall
	mov rax,60
	mov rdi,0

_tercera: 
	syscall

