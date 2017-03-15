%include "linux64.inc"
%include "macros.inc"


;							/* Código */

section .data

	; -------------------- Mensajes --------------------
	;NOTA: en caso de querer cambiar el color se modifica el #m.

	bienvenido: db  0x1b,"[38;5;183m","************************** Bienvenido al Emulador MIPS *************************", 0xa, 0xa
	lbienvenido: equ $-bienvenido
	lab: db 0x1b,"[38;5;86m", "        EL-4313 - Lab Estructura de Microprocesadores", 0xa
	llab: equ $-lab
	sem: db 0x1b,"[38;5;86m", "        IS - 2017", 0xa
	lsem: equ $-sem
	buscando: db 0x1b,"[38;5;86m","        Buscando archivo ROM.txt", 0xa
	lbuscando: equ $-buscando
	encuentra: db 0x1b,"[38;5;86m","        Archivo ROM.txt encontrado", 0xa
	lencuentra: equ $-encuentra
	noencuentra: db 0x1b, "[38;5;86m","        Archivo ROM.txt no encontrado", 0xa
	lnoencuentra: equ $-noencuentra
	inicio:  db 0x1b, "[38;5;86m","        Presione enter para continuar", 0xa
	linicio: equ $-inicio
	exito: db 0x1b, "[38;5;86m","        Ejecución exitosa", 0xa
	lexito: equ $-exito
	fallo: db 0x1b, "[38;5;86m","        Ejecución fallida", 0xa
	lfallo: equ $-fallo
	final: db 0x1b, "[38;5;86m","        Realizado por:", 0xa
	lfinal: equ $-final
	juan: db 0x1b, "[38;5;86m","      	  Juan José Vásquez ", 0xa
	ljuan: equ $-juan
	joao: db 0x1b, "[38;5;86m","     	  Joao Kmil Salas Ramirez 2014096609", 0xa
	ljoao: equ $-joao
	steven: db 0x1b, "[38;5;86m","      	  Steven León Domínguez 2014138025", 0xa
	lsteven: equ $-steven
	andre: db 0x1b, "[38;5;86m","     	  André Martínez Arana 2014068625", 0xa
	landre: equ $-andre
	camila: db 0x1b, "[38;5;86m","     	  Camila Gómez Molina 2014089559", 0xa
	lcamila: equ $-camila
	nfound: db 0x1b, "[38;5;86m","	La instrucción no ha sido encontrada", 0xa
	lnfound: equ $-nfound
	memmax: db 0x1b, "[38;5;41m","	Error: La dirección es mayor a la capacidad de memoria", 0xa
	lmemmax: equ $-memmax

	; -------------------- LECTURA ROM.TXsT --------------------
	file db "./ROM.txt", 0
	len equ 2048
	n db 0

	; -------------------- Imprimir registros --------------------
	filename: db "myfile.txt",0

section .bss

	; -------------------- LECTURA ROM.TXT --------------------
	buffer: resb 2048
	trama: resb 1

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

	; -------------------- Reservación en memoria para memoria de datos MIPS --------------------
	datos: resb 400

	; -------------------- Imprimir registros --------------------
	text resw 100 ;Reserva un espacio en memoria

section .text

	global _start

_start:

; -------------------- Imprimir mensajes de bienvenida --------------------
	printString bienvenido,lbienvenido ;Llamado al macro
	printString lab, llab
	printString sem, lsem
	printString buscando, lbuscando

; -------------------- ABRIR ROM.TXT --------------------
	mov ebx, file ; name of the file
	mov eax, 5
	mov ecx, 0
	int 80h

	mov eax, 3
	mov ebx, eax
	mov ecx, buffer
	mov edx, len
	int 80h

;-------------------- PASAR DE ASCII A ENTERO --------------------
	mov r8, [buffer]
	mov rax, 0
	mov rbx, 0

loop1:
	add rax, 11

	mov r8, [buffer+rax]
	ASCIIaENTERO r8
	inc rax

	mov r9, [buffer+rax]
	ASCIIaENTERO r9
	inc rax

	mov r10, [buffer+rax]
	ASCIIaENTERO r10
	inc rax

	mov r11, [buffer+rax]
	ASCIIaENTERO r11
	inc rax

	mov r12, [buffer+rax]
	ASCIIaENTERO r12
	inc rax

	mov r13, [buffer+rax]
	ASCIIaENTERO r13
	inc rax

	mov r14, [buffer+rax]
	ASCIIaENTERO r14
	inc rax

	mov r15, [buffer+rax]
	ASCIIaENTERO r15
	inc rax

;-------------------- GUARDAR EN MEMORIA --------------------
	HexMemoria r14,r15,rbx
	inc rbx
	HexMemoria r12,r13,rbx
	inc rbx
	HexMemoria r10,r11,rbx
	inc rbx
	HexMemoria r8,r9,rbx
	inc rbx

loop2:
	mov r8, [buffer+rax]
	and r8, 11111111b

	cmp r8, 0
	je end

	cmp r8, 10
	je esEnter
	inc rax
	jmp loop2

	esEnter:
	inc rax
	mov r8, [buffer+rax]
	and r8, 11111111b
	cmp r8, 0
	je end
	cmp r8, 10
	je esEnter
	jmp loop1

end:
	mov rax, eax
	separarJ rax
	jmp decode

_exit:
  mov eax, 1
  mov ebx, 0
  int 80h

; -------------------- Decodificación --------------------
decode:

	cmp r14, 000000b                    ;compara con 0 para ver si es una instrucción tipo R
	je R			                          ;en caso de serlo, salta a R

	cmp r14, 001000b                    ;compara con addi
	je sumai                            ;salta a .sumai
	cmp r14, 001001b                    ;compara con addiu
	je sumaiu                           ;salta a .sumaiu
	cmp r14, 001100b                    ;compara con andi
	je yi                               ;salta a .y
	cmp r14, 000100b                    ;compara con beq
	je beq                              ;salta a .beq
	cmp r14, 000101b                    ;compara con bne
	je bne                              ;salta a .bne
	cmp r14, 000010b                    ;compara con j
	je j                                ;salta a .j
	cmp r14, 000011b                    ;compara con jal
	je jandl                            ;salta a .jandl
	cmp r14, 001000b                    ;compara con jr
	je jr                               ;salta a .jr
	cmp r14, 100011b                    ;compara con lw
	je lw                               ;salta a .lw
	cmp r14, 001101b                    ;compara con ori
	je ori                              ;salta a .ori
	cmp r14, 001010b                    ;compara con slti
	je slti                             ;salta a .slti
	cmp r14, 001001b                    ;compara con sltiu
	je sltiu                            ;salta a .sltiu
	cmp r14, 101001b                    ;compara con sltu
	je sltu                             ;salta a .sltu
	cmp r14, 100011b                    ;compara con subu
	je restau                           ;salta a .restau
	cmp r14, 101011b                    ;compara con sw
	je sw                               ;salta a .sw

	jmp instnotfound                   ;si la instrucción no se
		                                      ;encuentra en el set que
		                                      ;maneja el procesador
		                                      ;se ejecuta una rutina que
		                                      ;lo informa en pantalla

R:
	separarR rax
	cmp r9, 0x20          		          ;compara con op code, en este caso de add
	je suma                             ;salta a la etiqueta correspondiente, en este caso .suma
	cmp r9, 0x24      		              ;compara con and
	je y                                ;salta a .y
	cmp r9, 0x18  	                    ;compara con mult
	je mult                             ;salta a .mult
	cmp r9, 0x27	                      ;compara con nor
	je nor                              ;salta a .nor
	cmp r9, 0x25                        ;compara con or
	je o                                ;salta a .o
	cmp r9, 0x2a                        ;compara con slt
	je slt                              ;salta a .slt
	cmp r9, 0x00                        ;compara con sll
	je sll                              ;salta a .sll
	cmp r9, 0x02                        ;compara con srl
	je srl                              ;salta a .srl
	cmp r9, 0x22                        ;compara con sub
	je resta                            ;salta a .resta

	jmp instnotfound                   ;si la instrucción no se
		                                      ;encuentra en el set que
		                                      ;maneja el procesador
		                                      ;se ejecuta una rutina que
		                                      ;lo informa en pantalla

; -------------------- Rutinas correspondientes a cada inst --------------------
suma:
	alu 2
	reg_mips r11
	mov [rsi], rbx ; Mueve resultado a registro mips rd.

sumau:
	alu 2 ; suma rax y rcx. resultado en rbx.
	reg_mips r11
	mov [rsi], rbx ; Mueve resultado a registro mips rd.

sumai:
	separarI rax
	reg_mips r13
	mov rax, rdi ; rax es rs en la alu.
	reg_mips r11
	mov rcx, rdi ; rcx es rt en la alu.
	alu 2
	reg_mips r12
	mov[rsi], rbx

sumaiu:
	separarI rax
	reg_mips r13
	mov rax, rdi ; rax es rs en la alu.
	reg_mips r11
	mov rcx, rdi ; rcx es rt en la alu.
	alu 2
	reg_mips r12
	mov[rsi], rbx

y:
	alu 0
	reg_mips r11
	mov [rsi], rbx ; Mueve resultado a registro mips rd.

yi:
	separarI rax ;
	reg_mips r13
	mov rax, rdi ; rax es rs en la alu.
	reg_mips r11
	mov rcx, rdi ; rcx es rt en la alu.
	alu 0 ; and rax y rcx
	reg_mips r12 ; r12 es rt
	mov [rsi], rbx ; Mueve resultado a registro mips rt

beq:
<<<<<<< HEAD
	;Compararacion para saber si se cumple el branch
	;brinca a calculo de nueva direccion branch
	;branch_new_addr
		; si no se cumple, pc+4
=======
	separarI rax
	reg_mips r13
	mov rax, rdi													  ;Guarda en rax el contenido de rs
	reg_mips r11
	mov rcx, rdi 													  ;Guarda en rcx el contenido de rt
	cmp r13, r11													  ;Compara si rs y rt son iguales

>>>>>>> aad042e59a5f095c40a1a9cf9820ef190c6d244a

bne:
	separarI rax
	reg_mips r13
	mov rax, rdi													  ;Guarda en rax el contenido de rs
	reg_mips r11
	mov rcx, rdi 													  ;Guarda en rcx el contenido de rt
	cmp r13, r11													  ;Compara si rs y rt son iguales

	;Compararacion para saber si se cumple el branch
	;brinca a calculo de nueva direccion branch
	;branch_new_addr:

branch_new_addr:
	SepararI rax
	branch_add r11;
	mov ebx, 0;
	mov ebx,r11

j:

jandl:

jr:

lw:
	separarI rax
	sign_ext r11														;Se toma el inmediato y se extiende el signo
	reg_mips r13														;se utiliza la macro para obtener el valor y dirección de Rs
	add r13, r11														;se suman ambos valores para calcular la dirección de memoria
	cmp r13, 100
	ja memoverflow
	mov rax, 4															;se multiplica por 4 ya que la memoria se divide en bytes (palabras de 4*8bits)
	mul r13
	add rax, datos 													;se suma a datos ya que es el valor inicial de memoria de datos en el computador real
	mov rax, [rax]													;se toma ese valor de memoria y se guarda de nuevo en rax
	reg_mips r12
	mov [rsi], rax													;se guarda el valor sacado de memoria de datos al registro destino Rt

mult:
	alu 6
	reg_mips r11
	mov [rsi], rbx ; Mueve resultado a registro mips rd.
nor:
	alu 5
	reg_mips r11
	mov [rsi], rbx ; Mueve resultado a registro mips rd.
o:
	alu 1
	reg_mips r11
	mov [rsi], rbx ; Mueve resultado a registro mips rd.
ori:
	separarI rax
	reg_mips r13
	mov rax, rdi ; rax es rs en la alu.
	reg_mips r11
	mov rcx, rdi ; rcx es rt en la alu.
	alu 1 ; or entre rax y rcx
	reg_mips r12 ; r12 es rt
	mov [rsi], rbx ; Mueve resultado a registro mips rt

slt:
	alu 4
	reg_mips r11
	mov [rsi], rbx ; Mueve resultado a registro mips rd.

sltu:
		alu 4
		reg_mips r11
		mov [rsi], rbx ; Mueve resultado a registro mips rd.

slti:
	separarI rax
	reg_mips r13
	mov rax, rdi ; rax es rs en la alu.
	reg_mips r11
	mov rcx, rdi ; rcx es rt en la alu.
	alu 4
	reg_mips r11
	mov [rsi], rbx ; Mueve resultado a registro mips rd.

sltiu:
	separarI rax
	reg_mips r13
	mov rax, rdi ; rax es rs en la alu.
	reg_mips r11
	mov rcx, rdi ; rcx es rt en la alu.
	alu 4
	reg_mips r11
	mov [rsi], rbx ; Mueve resultado a registro mips rd.


sll: ;SeparaR me da rax = rs y rcx = immediate
	shl  rax, rcx
	reg_mips r11
	mov [rsi], rax

srl: ;SeparaR me da rax = rs y rcx = immediate
	shr  rax, rcx
	reg_mips r11
	mov [rsi], rax

resta:
	alu 3
	reg_mips r11
	mov [rsi], rbx ; Mueve resultado a registro mips rd.

restau:
	alu 3
	reg_mips r11
	mov [rsi], rbx ; Mueve resultado a registro mips rd.

sw:
	separarI rax
	sign_ext r11														;Se toma el inmediato y se extiende el signo
	reg_mips r13														;se utiliza la macro para obtener el valor y dirección de Rs
	add r13, r11  													;se suman ambos valores para calcular la dirección de memoria
	cmp r13, 100
	ja memoverflow
	mov rax, 4															;se multiplica por 4 ya que la memoria se divide en bytes (palabras de 4*8bits)
	mul r13
	add rax, datos 													;se suma a datos ya que es el valor inicial de memoria de datos en el computador real
	reg_mips r12
	mov [rax], rdi													;se toma el valor de rt y se guarda en la dirección calculada en rax


memoverflow:
	printString memmax, lmemmax


nextinst:


; -------------------- Error de instruccíon no encontrada --------------------
instnotfound:
							printString nfound, lnfound

; -------------------- Imprimir registros --------------------
;printVal r8 ; Imprime registro del resultado.
