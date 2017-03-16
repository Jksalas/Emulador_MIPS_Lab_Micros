%include "linux64.inc"
%include "macros.inc"


;							/* Sección de variables sin inicializar */

section .bss

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

	; -------------------- Reservación en memoria para memoria de datos MIPS --------------------
	datos: resb 400

	; -------------------- Imprimir registros --------------------
	text resw 100 ;Reserva un espacio en memoria

;							/* Sección de código principal */

section .text

	global _start

_start:

; -------------------- Imprimir mensajes de bienvenida --------------------
	printString bienvenido,lbienvenido ;Llamado al macro
	printString lab, llab
	printString sem, lsem
	printString buscando, lbuscando

;-----------------------LECTURA ROM.TXT--------------------------------



;----------------ABRIR ROM.TXT---------------------
	mov ebx, file ; name of the file
	mov eax, 5
	mov ecx, 0
	int 80h

	mov eax, 3
	mov ebx, eax
	mov ecx, buffer
	mov edx, len
	int 80h

;-----------PASAR DE ASCII A ENTERO----------------
	mov r8, [buffer]
	mov rax, 0
	mov rbx, 0
	mov r15, 0

loop1:

	inc rax

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
;-------------GUARDAR PC EN MEMORIA------------------
	HexPC r14,r15,rbx
	inc rbx
	HexPC r12,r13,rbx
	inc rbx
	HexPC r10,r11,rbx
	inc rbx
	HexPC r8,r9,rbx
	inc rbx

	SUB rbx, 4
	add rax, 2

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
;-------------GUARDAR EN MEMORIA------------------
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
	je finLectura

	cmp r8, 10
	je esEnter
	inc rax
	jmp loop2

	esEnter:
	inc rax
	mov r8, [buffer+rax]
	and r8, 11111111b
	cmp r8, 0
	je finLectura
	cmp r8, 10
	je esEnter
	jmp loop1

determinarPC:

	; R15 registro PC

	cmp ebx, 0
	ja loopDeterminarPC
	add r15, 4
	mov eax, [trama+r15]
	jmp inicio

loopDeterminarPC:

	mov eax, [pc+r15]
	sub eax, ebx

	cmp eax, 0x80000000
	ja loopEsMayor

	sub r15d, eax
	mov eax, [trama+r15]
	jmp inicio

loopEsMayor:


	add r8d, eax
	not r8d
	inc r8
	add r15, r8
	mov eax, [trama+r15]
	jmp inicio

finLectura:
	mov ebx, 0;

inicio:
	separarJ rax
	jmp decode

_exit:
  mov eax, 1
  mov ebx, 0
  int 80h

; -------------------- Decodificación --------------------
decode:

	cmp r14, 000000b                        ;compara con 0 para ver si es una instrucción tipo R
	je R			                              ;en caso de serlo, salta a R

	cmp r14, 001000b                        ;compara con addi
	je sumai                                ;salta a .sumai
	cmp r14, 001001b                        ;compara con addiu
	je sumaiu               	              ;salta a .sumaiu
	cmp r14, 001100b    		                ;compara con andi
	je yi            		                    ;salta a .y
	cmp r14, 000100b                		    ;compara con beq
	je beq                      		        ;salta a .beq
	cmp r14, 000101b        		            ;compara con bne
	je bne              		                ;salta a .bne
	cmp r14, 000010b 		                    ;compara con j
	je j                		                ;salta a .j
	cmp r14, 000011b                		    ;compara con jal
	je jandl                    		        ;salta a .jandl
	cmp r14, 001000b        		            ;compara con jr
	je jr               		                ;salta a .jr
	cmp r14, 100011b 		                    ;compara con lw
	je lw                             		  ;salta a .lw
	cmp r14, 001101b              		      ;compara con ori
	je ori                    		          ;salta a .ori
	cmp r14, 001010b                  		  ;compara con slti
	je slti                       		      ;salta a .slti
	cmp r14, 001001b          		          ;compara con sltiu
	je sltiu              		              ;salta a .sltiu
	cmp r14, 101001b  		                  ;compara con sltu
	je sltu        		                      ;salta a .sltu
	cmp r14, 100011b                  		  ;compara con subu
	je restau                     		      ;salta a .restau
	cmp r14, 101011b          		          ;compara con sw
	je sw                 		              ;salta a .sw

	jmp instnotfound 			                  ;si la instrucción no se
		                                      ;encuentra en el set que
		                                      ;maneja el procesador
		                                      ;se ejecuta una rutina que
		                                      ;lo informa en pantalla

R:
	separarR rax
	cmp r9, 0x20  	 		       		          ;compara con op code, en este caso de add
	je suma     		                        ;salta a la etiqueta correspondiente, en este caso .suma
	cmp r9, 0x24      		              		;compara con and
	je y                            		    ;salta a .y
	cmp r9, 0x18  	            		        ;compara con mult
	je mult                 		            ;salta a .mult
	cmp r9, 0x27	      		                ;compara con nor
	je nor          		                    ;salta a .nor
	cmp r9, 0x25 		                        ;compara con or
	je o                          		      ;salta a .o
	cmp r9, 0x2a              		          ;compara con slt
	je slt                		              ;salta a .slt
	cmp r9, 0x00         	             		  ;compara con sll
	je sll                            		  ;salta a .sll
	cmp r9, 0x02                        		;compara con srl
	je srl                              		;salta a .srl
	cmp r9, 0x22                        		;compara con sub
	je resta                          		  ;salta a .resta

	jmp instnotfound                    		;si la instrucción no se
		                                      ;encuentra en el set que
		                                      ;maneja el procesador
		                                      ;se ejecuta una rutina que
		                                      ;lo informa en pantalla

; -------------------- Rutinas correspondientes a cada inst --------------------
suma:
	alu 2
	reg_mips r11
	mov [rsi], rbx 													; Mueve resultado a registro mips rd.
	mov ebx, 0
	jmp determinarPC

sumau:
	alu 2 																	; suma rax y rcx. resultado en rbx.
	reg_mips r11
	mov [rsi], rbx 													; Mueve resultado a registro mips rd.
	mov ebx, 0
	jmp determinarPC
sumai:
	separarI rax
	reg_mips r13
	mov rax, rdi 														; rax es rs en la alu.
	reg_mips r11
	mov rcx, rdi 														; rcx es rt en la alu.
	alu 2
	reg_mips r12
	mov[rsi], rbx
	mov ebx, 0
	jmp determinarPC
sumaiu:
	separarI rax
	reg_mips r13
	mov rax, rdi													  ; rax es rs en la alu.
	reg_mips r11
	mov rcx, rdi 														; rcx es rt en la alu.
	alu 2
	reg_mips r12
	mov[rsi], rbx
	mov ebx, 0
	jmp determinarPC
y:
	alu 0
	reg_mips r11
	mov [rsi], rbx										 			; Mueve resultado a registro mips rd.
	mov ebx, 0
	jmp determinarPC
yi:
	separarI rax
	reg_mips r13
	mov rax, rdi 											 			; rax es rs en la alu.
	reg_mips r11
	mov rcx, rdi														; rcx es rt en la alu.
	alu 0 														 			; and rax y rcx
	reg_mips r12 														; r12 es rt
	mov [rsi], rbx  									 			; Mueve resultado a registro mips rt
	mov ebx, 0
	jmp determinarPC
beq:
																			 	  ;Compararacion para saber si se cumple el branch
																				  ;brinca a calculo de nueva direccion branch
																				  ;branch_new_addr
																					 ; si no se cumple, pc+4

	separarI rax
	reg_mips r13
	mov r13, rdi														;Guarda en rax el contenido de rs
	reg_mips r12
	mov r12, rdi 														;Guarda en rcx el contenido de rt
	cmp r13, r12											 			;Compara si rs y rt son iguales
	je branch_new_addr
	mov ebx, 0
	jmp determinarPC
bne:
	separarI rax
	reg_mips r13
	mov r13, rdi													  ;Guarda en rax el contenido de rs
	reg_mips r12
	mov r12, rdi 													  ;Guarda en rcx el contenido de rt
	cmp r13, r12													  ;Compara si rs y rt son iguales
	jne branch_new_addr
	mov ebx, 0
	jmp determinarPC
	;Compararacion para saber si se cumple el branch
	;brinca a calculo de nueva direccion branch
	;branch_new_addr:

branch_new_addr:
	separarI rax
	branch_add r11;
	mov ebx, 0;
	mov ebx,r11d
	mov ebx, 0
	jmp determinarPC
j:
	mov ebx,0x00000000
	mov r14, [pc+r15+4]
	and r14d,0xF0000000;
	mov ebx,r14d; ebx nuevo PC
	shr ebx,2;newPC=PC+4[31:28]
	and eax,0x03FFFFFF;
	add ebx,eax
	shl ebx,2;
	jmp determinarPC
jandl:
	mov ebx,0
	mov r14, [pc+r15+4]
	and r14d,0xF0000000;
	mov ebx,r14d; ebx nuevo PC
	shl ebx,26; newPC=PC+4[31:28]
	and eax,0x03FFFFFF;
	add ebx,eax;
	shl ebx,2;
	jmp determinarPC
jr:
	mov ebx,0
	mov r14, [pc+r15+4]
	and r14d,0xF0000000;
	mov ebx,r14d; ebx nuevo PC
	shl ebx,26; newPC=PC+4[31:28]
	and eax,0x03FFFFFF;
	add ebx,eax;
	shl ebx,2;
	jmp determinarPC
lw:
	separarI rax
	sign_ext r11														;Se toma el inmediato y se extiende el signo
	reg_mips r13
	mov r13, rdi														;se utiliza la macro para obtener el valor y dirección de Rs
	add r13, r11														;se suman ambos valores para calcular la dirección de memoria
	cmp r13, 100
	ja memoverflow
	mov rax, 4															;se multiplica por 4 ya que la memoria se divide en bytes (palabras de 4*8bits)
	mul r13
	add rax, datos 													;se suma a datos ya que es el valor inicial de memoria de datos en el computador real
	mov rax, [rax]													;se toma ese valor de memoria y se guarda de nuevo en rax
	reg_mips r12
	mov [rsi], rax													;se guarda el valor sacado de memoria de datos al registro destino Rt
	mov ebx, 0
	jmp determinarPC
mult:
	alu 6
	reg_mips r11
	mov [rsi], rbx 													; Mueve resultado a registro mips rd.
	mov ebx, 0
	jmp determinarPC
nor:
	alu 5
	reg_mips r11
	mov [rsi], rbx 													; Mueve resultado a registro mips rd.
	mov ebx, 0
	jmp determinarPC
o:
	alu 1
	reg_mips r11
	mov [rsi], rbx 													; Mueve resultado a registro mips rd.
	mov ebx, 0
	jmp determinarPC
ori:
	separarI rax
	reg_mips r13
	mov rax, rdi 														; rax es rs en la alu.
	reg_mips r11
	mov rcx, rdi 														; rcx es rt en la alu.
	alu 1 																	; or entre rax y rcx
	reg_mips r12 														; r12 es rt
	mov [rsi], rbx 													; Mueve resultado a registro mips rt
	mov ebx, 0
	jmp determinarPC
slt:
	alu 4
	reg_mips r11
	mov [rsi], rbx												  ; Mueve resultado a registro mips rd.
	mov ebx, 0
	jmp determinarPC
sltu:
	alu 4
	reg_mips r11
	mov [rsi], rbx 												; Mueve resultado a registro mips rd.
	mov ebx, 0
	jmp determinarPC
slti:
	separarI rax
	reg_mips r13
	mov rax, rdi 														; rax es rs en la alu.
	reg_mips r11
	mov rcx, rdi 														; rcx es rt en la alu.
	alu 4
	reg_mips r11
	mov [rsi], rbx 													; Mueve resultado a registro mips rd.
	mov ebx, 0
	jmp determinarPC
sltiu:
	separarI rax
	reg_mips r13
	mov rax, rdi 														; rax es rs en la alu.
	reg_mips r11
	mov rcx, rdi 														; rcx es rt en la alu.
	alu 4
	reg_mips r11
	mov [rsi], rbx 													; Mueve resultado a registro mips rd.
	mov ebx, 0
	jmp determinarPC

sll:
	reg_mips r12
	mov r8, rdi
	shl r8, r10
	reg_mips r11
	mov [rsi], r8
	mov ebx, 0
	jmp determinarPC
srl:
	reg_mips r12
	mov r8, rdi
	shr r8, r10
	reg_mips r11
	mov [rsi], r8
	mov ebx, 0
	jmp determinarPC
resta:
	alu 3
	reg_mips r11
	mov [rsi], rbx 													; Mueve resultado a registro mips rd.
	mov ebx, 0
	jmp determinarPC
restau:
	alu 3
	reg_mips r11
	mov [rsi], rbx 													; Mueve resultado a registro mips rd.
	mov ebx, 0
	jmp determinarPC
sw:
	separarI rax
	sign_ext r11														;Se toma el inmediato y se extiende el signo
	reg_mips r13
	mov r13, rdi														;se utiliza la macro para obtener el valor y dirección de Rs
	add r13, r11  													;se suman ambos valores para calcular la dirección de memoria
	cmp r13, 100
	ja memoverflow
	mov rax, 4															;se multiplica por 4 ya que la memoria se divide en bytes (palabras de 4*8bits)
	mul r13
	add rax, datos 													;se suma a datos ya que es el valor inicial de memoria de datos en el computador real
	reg_mips r12
	mov [rax], rdi													;se toma el valor de rt y se guarda en la dirección calculada en rax
	mov ebx, 0
	jmp determinarPC
; -------------------- Error de dirección de memoria no encontrada --------------------
memoverflow:
	printString memmax, lmemmax

; -------------------- PC + 4 --------------------
nextinst:


; -------------------- Error de instruccíon no encontrada --------------------
instnotfound:
							printString nfound, lnfound

; -------------------- Imprimir registros --------------------
