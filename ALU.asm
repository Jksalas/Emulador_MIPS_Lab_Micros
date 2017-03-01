%macro alu 1 ; 1 parámetro como "señal de ctrl".
	mov rsi, %1 ; "OP Code" de ALU. Se guarda en rsi.

%%and:
	cmp rsi, 0d ; 0d = AND.
	jne %%or ; Si no es, pasa a siguiente opción.
	and rax, rcx ; rax (rs) AND rcx (rt).
	jmp %%result ; Concluida la operación, pasa a resultado.

%%or:
	cmp rsi, 1d ; 1d = OR.
	jne %%add ; Si no es, pasa a siguiente opción.
	or rax, rcx ; rax (rs) OR rcx (rt).
	jmp %%result ; Concluida la operación, pasa a resultado.

%%add:
	cmp rsi, 2d ; 2d = ADD.
	jne %%substract ; Si no es, pasa a siguiente opción.
	add rax, rcx ; rax (rs) + rcx (rt).
	jmp %%result ; Concluida la operación, pasa a resultado.

%%substract:
	cmp rsi, 3d; 3d = SUB.
	jne %%set_on_less_than ; Si no es, pasa a siguiente opción.
	sub rax, rcx ; rax (rs) - rcx (rt).
	jmp %%result ; Concluida la operación, pasa a resultado.

%%set_on_less_than:
	cmp rsi, 4d; 4d = SLTU.
	jne %%nor ; Si no es, pasa a siguiente opción.
	cmp rcx, rax
	jg %%true  ; Si rcx (rt) > rax(rs).
	jmp %%false ; Si no.

	%%true:
		mov rbp, 1b ; Un 1 en rbp (rd).
		jmp %%end ; Se pasa a fin porque ya resultado está en rd.

	%%false:
		mov rbp, 0b ; Un 0 en rbp (rd).
		jmp %%end ; Se pasa a fin porque ya resultado está en rd.

%%nor:
	cmp rsi, 5d; 5d = NOR.
	jne %%multiply ; Si no es, pasa a siguiente opción.
	or rax, rcx ; rax (rs) OR rcx (rt).
	not rax ; NOT rax (rs).
	jmp %%result ; Concluida la operación, pasa a resultado.

%%multiply:
	cmp rsi, 6d ; 6d = MULT.
	jne %%end ; Si no es, pasa a resultal sin hacer nada.
	mul rcx ; rax (rs) * rcx (rt).
	jmp %%result ; Concluida la operación, pasa a resultado.

%%result: ; Las operaciones realizadas ponen su resultado en rax.
	mov rbp, rax ; Mueve resultado de operación a rbp (rd).

%%end: ; Etiqueta para casos de no hacer nada.

%endmacro

section .text

	global _start

_start:
	mov rax, 3
	mov rcx, 4
	alu 6d ; mult.

	mov rax, 60	; Se carga la llamada 60d (sys_exit) en rax.
	mov rdi, 0	; En rdi se carga un 0.
	syscall
