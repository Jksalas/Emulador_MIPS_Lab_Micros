%macro ImprimirRegistros 0
	
	printString linea, llinea
	mov r9, 0
%%L90:

	cmp r9, 31
	ja %%endloop90

;--------------------v0 v1----------------------
	cmp r9, 2
	jne %%l20
	printString reg2s, lreg2s
	mov eax, [reg2]
	jmp %%imprimirloop
%%l20:

	cmp r9, 3
	jne %%l21
	printString reg3s, lreg3s
	mov eax, [reg3]
	jmp %%imprimirloop
%%l21:
;-----------------a0 a1 a2 a3-----------------
	cmp r9, 4
	jne %%l22
	printString reg4s, lreg4s
	mov eax, [reg4]
	jmp %%imprimirloop
%%l22:

	cmp r9, 5
	jne %%l23
	printString reg5s, lreg5s
	mov eax, [reg5]
	jmp %%imprimirloop
%%l23:

	cmp r9, 6
	jne %%l24
	printString reg6s, lreg6s
	mov eax, [reg6]
	jmp %%imprimirloop
%%l24:

	cmp r9, 7
	jne %%l25
	printString reg7s, lreg7s
	mov eax, [reg7]
	jmp %%imprimirloop
%%l25:

;---------------------------------------

	cmp r9, 16
	jne %%l26
	printString reg16s, lreg16s
	mov eax, [reg16]
	jmp %%imprimirloop
%%l26:

	cmp r9, 17
	jne %%l27
	printString reg17s, lreg17s
	mov eax, [reg17]
	jmp %%imprimirloop
%%l27:

	cmp r9, 18
	jne %%l28
	printString reg18s, lreg18s
	mov eax, [reg18]
	jmp %%imprimirloop
%%l28:

	cmp r9, 19
	jne %%l29
	printString reg19s, lreg19s
	mov eax, [reg19]
	jmp %%imprimirloop
%%l29:

	cmp r9, 20
	jne %%l30
	printString reg20s, lreg20s
	mov eax, [reg20]
	jmp %%imprimirloop
%%l30:

	cmp r9, 21
	jne %%l31
	printString reg21s, lreg21s
	mov eax, [reg21]
	jmp %%imprimirloop
%%l31:

	cmp r9, 22
	jne %%l32
	printString reg22s, lreg22s
	mov eax, [reg22]
	jmp %%imprimirloop
%%l32:

	cmp r9, 23
	jne %%l33
	printString reg23s, lreg23s
	mov eax, [reg23]
	jmp %%imprimirloop
%%l33:

	inc r9
	jmp %%L90


%%imprimirloop:

	printVal rax
	printString nuevaLinea, 1
	inc r9
	jmp %%L90
%%endloop90:

	printString linea2, llinea2

%endmacro

%macro printString 2
  mov rax, 1
  mov rdi, 1
  mov rsi, %1
  mov rdx, %2
  syscall
%endmacro

%macro printVal 1
	mov rax, %1
%%printRAX:
	mov rcx, digitSpace
	mov rbx, 10
	mov [rcx], rbx
;	inc rcx
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
;	mov [digitSpacePos], 0x00000000

%endmacro

section .data
	linea: db  0x1b,"[38;5;30m","**********************REGISTROS MIPS**********************", 0xa
	llinea: equ $-linea
	linea2: db  0x1b,"[38;5;30m","**********************************************************", 0xa
	llinea2: equ $-linea2
	nuevaLinea: db 10
	tab: db 9
	reg2s: db  0x1b,"[38;5;35m","$v0	"
	lreg2s: equ $-reg2s
	reg3s: db  0x1b,"[38;5;35m","$v1	"
	lreg3s: equ $-reg3s	
	reg4s: db  0x1b,"[38;5;35m","$a0	"
	lreg4s: equ $-reg4s
	reg5s: db  0x1b,"[38;5;35m","$a1	"
	lreg5s: equ $-reg5s
	reg6s: db  0x1b,"[38;5;35m","$a2	"
	lreg6s: equ $-reg6s
	reg7s: db  0x1b,"[38;5;35m","$a3	"
	lreg7s: equ $-reg7s
	reg16s: db  0x1b,"[38;5;35m","$s0	"
	lreg16s: equ $-reg16s
	reg17s: db  0x1b,"[38;5;35m","$s1	"
	lreg17s: equ $-reg17s
	reg18s: db  0x1b,"[38;5;35m","$s2	"
	lreg18s: equ $-reg18s
	reg19s: db  0x1b,"[38;5;35m","$s3	"
	lreg19s: equ $-reg19s
	reg20s: db  0x1b,"[38;5;35m","$s4	"
	lreg20s: equ $-reg20s
	reg21s: db  0x1b,"[38;5;35m","$s5	"
	lreg21s: equ $-reg21s
	reg22s: db  0x1b,"[38;5;35m","$s6	"
	lreg22s: equ $-reg22s
	reg23s: db  0x1b,"[38;5;35m","$s7	"
	lreg23s: equ $-reg23s

section .bss
	digitSpace resb 100
	digitSpacePos resb 8
	printSpace resb 8
	; -------------------- LECTURA ROM.TXT --------------------
	buffer: resb 2048
	trama: resb 2048
	pc: resb 2048

	; -------------------- Reservación en memoria para registros MIPS --------------------
	; De 4 bytes = 32 bits.
	reg0: resb 4
	reg1: resb 4
	reg2: resb 4
	reg3: resb 4
	reg4: resb 4
	reg5: resb 4
	reg6: resb 4
	reg7: resb 4
	reg8: resb 4
	reg9: resb 4
	reg10: resb 4
	reg11: resb 4
	reg12: resb 4
	reg13: resb 4
	reg14: resb 4
	reg15: resb 4
	reg16: resb 4
	reg17: resb 4
	reg18: resb 4
	reg19: resb 4
	reg20: resb 4
	reg21: resb 4
	reg22: resb 4
	reg23: resb 4
	reg24: resb 4
	reg25: resb 4
	reg26: resb 4
	reg27: resb 4
	reg28: resb 4
	reg29: resb 4
	reg30: resb 4
	reg31: resb 4

	resmult: resb 8; 64 bits para resultado de multiplicación.

section .text
global _start

_start:
	;mov byte[reg2], 0xa
	;mov byte[reg16], 0xf
	;mov byte[reg23], 0xc

	ImprimirRegistros
_exit
	mov rax, 60
	mov rdi, 0
	syscall