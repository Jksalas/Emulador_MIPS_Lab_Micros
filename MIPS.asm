%include "linux64.inc"
%include "macros.inc"

;							/* Sección de código principal */

section .text

	global _start

_start:

; -------------------- Imprimir mensajes de bienvenida --------------------
	printString bienvenido,lbienvenido ;Llamado al macro
	printString lab, llab
	printString sem, lsem
	printString buscando, lbuscando

; -----------------------LECTURA ROM.TXT--------------------------------

; ----------------ABRIR ROM.TXT---------------------
	mov ebx, file ; name of the file
	mov eax, 5
	mov ecx, 0
	int 80h

	mov eax, 3
	mov ebx, eax
	mov ecx, buffer
	mov edx, len
	int 80h

; -----------PASAR DE ASCII A ENTERO----------------
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

; -------------GUARDAR PC EN MEMORIA------------------
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

; -------------GUARDAR EN MEMORIA------------------
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
	mov eax, [trama+r15]
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
	cmp r9, 0x21  	 		       		          ;compara con op code, en este caso de addu
	je sumau     		                        ;salta a la etiqueta correspondiente, en este caso .sumau
	cmp r9, 0x24      		              		;compara con and
	je y                            		    ;salta a .y
	cmp r14, 0x08           		            ;compara con jr
	je jr               		                ;salta a .jr
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
	mov r14, rax
	printString sumar, lsumar
	separarR r14
	printVal r11
	printString comma, lcomma
	printString dolar, ldolar
	printVal r13
	printString comma, lcomma
	printString dolar, ldolar
	separarR r14
	printVal r12
	printString retorno, lretorno
	separarR r14
	alu 2
	reg_mips r11
	mov [rsi], rbx 													; Mueve resultado a registro mips rd.
	mov ebx, 0
	jmp determinarPC

sumau:
	mov r14, rax
	printString sumaru, lsumaru
	separarR r14
	printVal r11
	printString comma, lcomma
	printString dolar, ldolar
	printVal r13
	printString comma, lcomma
	printString dolar, ldolar
	separarR r14
	printVal r12
	printString retorno, lretorno
	separarR r14
	alu 2 																	; suma rax y rcx. resultado en rbx.
	reg_mips r11
	mov [rsi], rbx 													; Mueve resultado a registro mips rd.
	mov ebx, 0
	jmp determinarPC

sumai:
	mov r14, rax
	printString sumari, lsumari
	separarI r14
	printVal r12
	printString comma, lcomma
	printString dolar, ldolar
	printVal r13
	printString comma, lcomma
	separarI r14
	printVal r11
	printString retorno, lretorno
	separarI r14
	reg_mips r13
	mov rax, rdi 														; rax es rs en la alu.
	mov rcx, r11 														; rcx es rt en la alu.
	alu 2
	reg_mips r12
	mov[rsi], rbx
	mov ebx, 0
	jmp determinarPC

sumaiu:
	mov r14, rax
	printString sumari, lsumari
	separarI r14
	printVal r12
	printString comma, lcomma
	printString dolar, ldolar
	printVal r13
	printString comma, lcomma
	separarI r14
	printVal r11
	printString retorno, lretorno
	separarI r14
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
	mov r14, rax
	printString lalaland, lalalaland
	separarR r14
	printVal r11
	printString comma, lcomma
	printString dolar, ldolar
	printVal r13
	printString comma, lcomma
	printString dolar, ldolar
	separarR r14
	printVal r12
	printString retorno, lretorno
	separarR r14
	alu 0
	reg_mips r11
	mov [rsi], rbx										 			; Mueve resultado a registro mips rd.
	mov ebx, 0
	jmp determinarPC

yi:
	mov r14, rax
	printString lalalandi, lalalalandi
	separarI r14
	printVal r12
	printString comma, lcomma
	printString dolar, ldolar
	printVal r13
	printString comma, lcomma
	separarI r14
	printVal r11
	printString retorno, lretorno
	separarI r14
	reg_mips r13
	mov rax, rdi 											 			; rax es rs en la alu.
	reg_mips r11
	mov rcx, rdi														; rcx es rt en la alu.
	alu 0 														 			; and rax y rcx
	reg_mips r12 														; r12 es rt
	mov [rsi], rbx  									 			; Mueve resultado a registro mips rt
	mov ebx, 0
	jmp determinarPC

																					 	  ;Compararacion para saber si se cumple el branch
																						  ;brinca a calculo de nueva direccion branch
																						  ;branch_new_addr
beq:
	mov r14, rax
	printString branchequal, lbranchequal
	separarI r14
	printVal r12
	printString comma, lcomma
	printString dolar, ldolar
	printVal r13
	printString comma, lcomma
	separarI r14
	printVal r11
	printString retorno, lretorno
	separarI r14
	reg_mips r13
	mov r13, rdi														;Guarda en rax el contenido de rs
	reg_mips r12
	mov r12, rdi 														;Guarda en rcx el contenido de rt
	cmp r13, r12											 			;Compara si rs y rt son iguales
	je branch_new_addr
	mov ebx, 0
	jmp determinarPC												; si no se cumple, pc+4

bne:
	mov r14, rax
	printString branchnequal, lbranchnequal
	separarI r14
	printVal r12
	printString comma, lcomma
	printString dolar, ldolar
	printVal r13
	printString comma, lcomma
	separarI r14
	printVal r11
	printString retorno, lretorno
	separarI r14
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
	mov r14, rax
	printString jump, ljump
	separarJ r14
	printVal r13
	printString retorno, lretorno
	separarJ r14
	mov ebx,0x00000000
	mov r14, [pc+r15+4]
	and r14d,0xF0000000;
	mov ebx,r14d; ebx nuevo PC
	shr ebx,2;newPC=PC+4[31:28]
	and eax,0x03FFFFFF;
	add ebx,eax
	shl ebx,2;
	printString jump, ljump
	jmp determinarPC

jandl:
	mov r14, rax
	printString jumpal, ljumpal
	separarJ r14
	printVal r13
	printString retorno, lretorno
	separarJ r14
	mov ebx,0
	mov r14, [pc+r15+4]
	and r14d,0xF0000000;
	mov ebx,r14d; ebx nuevo PC
	shl ebx,26; newPC=PC+4[31:28]
	and eax,0x03FFFFFF;
	add ebx,eax;
	shl ebx,2;
	printString jumpal, ljumpal
	jmp determinarPC

jr:
	mov r14, rax
	printString jumpreg, ljumpreg
	separarR r14
	printVal r13
	printString retorno, lretorno
	separarR r14
	mov ebx,0
	mov r14, [pc+r15+4]
	and r14d,0xF0000000;
	mov ebx,r14d; ebx nuevo PC
	shl ebx,26; newPC=PC+4[31:28]
	and eax,0x03FFFFFF;
	add ebx,eax;
	shl ebx,2;
	printString jumpreg, ljumpreg
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
	printString loadw, lloadw
	jmp determinarPC

mult:
	mov r14, rax ; Mueve la instrucción a r14.
	printString multiplicar, lmultiplicar ; Imprime mnemonico.
	separarR r14
	printVal r13 ; Imprime rs.
	printString comma, lcomma
	printString dolar, ldolar
	separarR r14
	printVal r12 ; Imprime rt.
	printString retorno, lretorno
	separarR r14


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
	printString nordico, lnordico
	jmp determinarPC

o:
	mov r14, rax ; Mueve la instrucción a r14.
	printString orcito, lorcito ; Imprime mnemonico.
	separarR r14
	printVal r11 ; Imprime rd.
	printString comma, lcomma
	printString dolar, ldolar
	separarR r14
	printVal r13 ; Imprime rs.
	printString comma, lcomma
	printString dolar, ldolar
	separarR r14
	printVal r12 ; Imprime rt.
	printString retorno, lretorno
	separarR r14

	alu 1
	reg_mips r11
	mov [rsi], rbx 													; Mueve resultado a registro mips rd.
	mov ebx, 0

	jmp determinarPC

ori:
	mov r14, rax ; Mueve instrucción a r14.
	printString oricito, loricito ; Imprime mnemonico.
	printVal r12 ; Imprime rt.
	separarI r14
	printString comma, lcomma
	printString dolar, ldolar
	separarI r14
	printVal r13 ; Imprime rs.
	printString comma, lcomma
	separarI r14
	printVal r11 ; Imprime inmediato.
	printString retorno, lretorno
	separarI r14

	reg_mips r13
	mov rax, rdi 														; rax es rs en la alu.
	mov rcx, r11 														; rcx es rt en la alu.
	alu 1 																	; or entre rax y rcx
	reg_mips r12 														; r12 es rt
	mov [rsi], rbx 													; Mueve resultado a registro mips rt
	mov ebx, 0

	jmp determinarPC

slt:
	mov r14, rax ; Mueve la instrucción a r14.
	printString slthan, lslthan ; Imprime mnemonico.
	separarR r14
	printVal r11 ; Imprime rd.
	printString comma, lcomma
	printString dolar, ldolar
	separarR r14
	printVal r13 ; Imprime rs.
	printString comma, lcomma
	printString dolar, ldolar
	separarR r14
	printVal r12 ; Imprime rt.
	printString retorno, lretorno
	separarR r14

	alu 4
	reg_mips r11
	mov [rsi], rbx												  ; Mueve resultado a registro mips rd.
	mov ebx, 0

	jmp determinarPC

sltu:
	mov r14, rax ; Mueve la instrucción a r14.
	printString slthanu, lslthanu ; Imprime mnemonico.
	separarR r14
	printVal r11 ; Imprime rd.
	printString comma, lcomma
	printString dolar, ldolar
	separarR r14
	printVal r13 ; Imprime rs.
	printString comma, lcomma
	printString dolar, ldolar
	separarR r14
	printVal r12 ; Imprime rt.
	printString retorno, lretorno
	separarR r14

	alu 4
	reg_mips r11
	mov [rsi], rbx 												; Mueve resultado a registro mips rd.
	mov ebx, 0

	jmp determinarPC

slti:
	mov r14, rax ; Mueve instrucción a r14.
	printString slthani, lslthani ; Imprime mnemonico.
	separarI r14
	printVal r12 ; Imprime rt.
	printString comma, lcomma
	printString dolar, ldolar
	separarI r14
	printVal r13 ; Imprimer rs.
	printString comma, lcomma
	separarI r14
	printVal r11 ; Imprime inmediato.
	printString retorno, lretorno
	separarI r14

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
	mov r14, rax ; Mueve instrucción a r14.
	printString slthaniu, lslthaniu ; Imprime mnemonico.
	separarI r14
	printVal r12 ; Imprime rt.
	printString comma, lcomma
	printString dolar, ldolar
	separarI r14
	printVal r13 ; Imprimer rs.
	printString comma, lcomma
	separarI r14
	printVal r11 ; Imprime inmediato.
	printString retorno, lretorno
	separarI r14

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
	mov r14, rax ; Mueve la instrucción a r14.
	printString shiftl, lshiftl ; Imprime mnemonico.
	separarR r14
	printVal r11 ; Imprime rd.
	printString comma, lcomma
	printString dolar, ldolar
	separarR r14
	printVal r12 ; Imprime rt.
	printString comma, lcomma
	printString dolar, ldolar
	separarR r14
	printVal r10 ; Imprime shamt.
	printString retorno, lretorno
	separarR r14

	reg_mips r12
	mov r8, rdi
	mov rcx, r10
	shl r8, cl
	reg_mips r11
	mov [rsi], r8
	mov ebx, 0

	jmp determinarPC

srl:
	mov r14, rax ; Mueve la instrucción a r14.
	printString shiftr, lshiftr ; Imprime mnemonico.
	separarR r14
	printVal r11 ; Imprime rd.
	printString comma, lcomma
	printString dolar, ldolar
	separarR r14
	printVal r12 ; Imprime rt.
	printString comma, lcomma
	printString dolar, ldolar
	separarR r14
	printVal r10 ; Imprime shamt.
	printString retorno, lretorno
	separarR r14

	reg_mips r12
	mov r8, rdi
	mov rcx, r10
	shr r8, cl
	reg_mips r11
	mov [rsi], r8
	mov ebx, 0

	jmp determinarPC

resta:
	mov r14, rax ; Mueve la instrucción a r14.
	printString restar, lrestar ; Imprime mnemonico.
	separarR r14
	printVal r11 ; Imprime rd.
	printString comma, lcomma
	printString dolar, ldolar
	separarR r14
	printVal r13 ; Imprime rs.
	printString comma, lcomma
	printString dolar, ldolar
	separarR r14
	printVal r12 ; Imprime rt.
	printString retorno, lretorno
	separarR r14

	alu 3
	reg_mips r11
	mov [rsi], rbx 													; Mueve resultado a registro mips rd.
	mov ebx, 0

	jmp determinarPC

restau:
	mov r14, rax ; Mueve la instrucción a r14.
	printString restaru, lrestaru ; Imprime mnemonico.
	separarR r14
	printVal r11 ; Imprime rd.
	printString comma, lcomma
	printString dolar, ldolar
	separarR r14
	printVal r13 ; Imprime rs.
	printString comma, lcomma
	printString dolar, ldolar
	separarR r14
	printVal r12 ; Imprime rt.
	printString retorno, lretorno
	separarR r14

	alu 3
	reg_mips r11
	mov [rsi], rbx 													; Mueve resultado a registro mips rd.
	mov ebx, 0

	jmp determinarPC

sw:
	mov r14, rax ; Mueve instrucción a r14.
	printString storew, lstorew ; Imprime mnemonico.
	separarI r14
	printVal r12 ; Imprime rt.
	printString comma, lcomma
	separarI r14
	printVal r11 ; Imprime inmediato.
	printString parentizq, lparentizq
	printString dolar, ldolar
	separarI r14
	printVal r13 ; Imprime rs.
	printString parentder, lparentder
	printString retorno, lretorno
	separarI r14

	sign_ext r11														;Se toma el inmediato y se extiende el signo
	reg_mips r13														;se utiliza la macro para obtener el valor y dirección de Rs
	mov r13, rdi
	add r13, r11  													;se suman ambos valores para calcular la dirección de memoria
	cmp r13, 99
	ja memoverflow													;si se sobrepasa de las 100 palabras de memoria, imprime mensaje de error.
	mov rax, 4
	mul r13																	;se multiplica por 4 ya que la memoria se divide en bytes (palabras de 4*8bits)
	add rax, datos 													;se suma a datos ya que es el valor inicial de memoria de datos en el computador real.
	reg_mips r12
	mov [rax], rdi													;se toma el valor de rt y se guarda en la dirección calculada en rax
	mov ebx, 0

	jmp determinarPC
; -------------------- Error de dirección de memoria no encontrada --------------------
memoverflow:
	printString memmax, lmemmax

; -------------------- PC + 4 --------------------
;nextinst:


; -------------------- Error de instruccíon no encontrada --------------------
instnotfound:
							printString nfound, lnfound

; -------------------- Imprimir registros --------------------
