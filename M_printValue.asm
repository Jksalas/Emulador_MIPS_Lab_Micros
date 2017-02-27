%include "linux64.inc"

;Macro para imprimir contenido de registros 

%macro printValue 1

	mov rax, %1 ;Al registro rax se le asigna el parámetro de entrada

	%%printRAX:

		mov rcx, digitSpace 
		mov [digitSpacePos], rcx

	%%printRAXLoop:

		mov rdx, 0 
		mov rbx, 10
		div rbx
		push rax
		add rdx, 48

		mov rcx, [digitSpacePos]
		mov [rcx], dl
		inc rcx
		mov [digitSpacePos], rcx
	
		pop rax
		cmp rax, 0
		jne %%printRAXLoop

	%%printRAXLoop2:

		mov rcx, [digitSpacePos]

		mov rax, 1
		mov rdi, 1
		mov rsi, rcx
		mov rdx, 1
		syscall

		mov rcx, [digitSpacePos]
		dec rcx
		mov [digitSpacePos], rcx

		cmp rcx, digitSpace
		
		jge %%printRAXLoop2
		mov rax, SYS_CLOSE
		pop rdi
		syscall

		print text
		exit
%endmacro

section .text
	global _start

section .bss  
	text resw 100 ;Reserva un espacio en memoria 

section .data
	filename: db "myfile.txt",0
_start:

	mov r8, 10   ;Prueba 
	printValue r8 ;Llamado al macro
	syscall ;


