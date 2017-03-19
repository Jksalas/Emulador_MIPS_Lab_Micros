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

	; r15 registro PC
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
	cmp rax, 0x0000000000000000
	je instnotfound
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
	cmp r14, 001011b          		          ;compara con sltiu
	je sltiu              		              ;salta a .sltiu
	cmp r14, 101011b          		          ;compara con sw
	je sw                 		              ;salta a .sw

	jmp instnotfound 			                  ;si la instrucción no se
		                                      ;encuentra en el set que
		                                      ;maneja el procesador
		                                      ;se ejecuta una rutina que
		                                      ;lo informa en pantalla

R:
	mov r14, rax
	separarR r14
	cmp r9, 0x20  	 		       		          ;compara con op code, en este caso de add
	je suma     		                        ;salta a la etiqueta correspondiente, en este caso .suma
	cmp r9, 0x21  	 		       		          ;compara con op code, en este caso de addu
	je sumau     		                        ;salta a la etiqueta correspondiente, en este caso .sumau
	cmp r9, 0x24      		              		;compara con and
	je y                            		    ;salta a .y
	cmp r9, 0x08           		            	;compara con jr
	je jr               		                ;salta a .jr
	cmp r9, 0x18  	            		        ;compara con mult
	je mult                 		            ;salta a .mult
	cmp r9, 0x27	      		                ;compara con nor
	je nor          		                    ;salta a .nor
	cmp r9, 0x25 		                        ;compara con or
	je o                          		      ;salta a .o
	cmp r9, 0x2a              		          ;compara con slt
	je slt                		              ;salta a .slt
	cmp r9, 0x2b  		  		                ;compara con sltu
	je sltu        		                      ;salta a .sltu
	cmp r9, 0x00         	             		  ;compara con sll
	je sll                            		  ;salta a .sll
	cmp r9, 0x02                        		;compara con srl
	je srl                              		;salta a .srl
	cmp r9, 0x22                        		;compara con sub
	je resta                          		  ;salta a .resta
	cmp r9, 0x23                     		    ;compara con subu
	je restau                     		      ;salta a .restau

	jmp instnotfound                    		;si la instrucción no se
		                                      ;encuentra en el set que
		                                      ;maneja el procesador
		                                      ;se ejecuta una rutina que
		                                      ;lo informa en pantalla

; -------------------- Rutinas correspondientes a cada inst --------------------
suma:	;Tipo R.
	printString sumar, lsumar 							; Imprime mnemónico.
	separarR r14
	printVal r11 														; Imprime rd.
	printString comma, lcomma
	printString dolar, ldolar
	printVal r13 														; Imprime rs.
	printString comma, lcomma
	printString dolar, ldolar
	printVal r12 														; Imprime rt.
	printString retorno, lretorno
	separarR r14 														; Asegurarse de que no se hayan perdido los datos de la instrucción.

	alu 2
	reg_mips r11
	mov [rsi], rbx 													; Mueve resultado a registro mips rd.
	mov ebx, 0
	jmp determinarPC

sumau:	;Tipo R.
	printString sumaru, lsumaru 						; Imprime mnemónico.
	separarR r14
	printVal r11 														; Imprime rd.
	printString comma, lcomma
	printString dolar, ldolar
	printVal r13 														; Imprime rs.
	printString comma, lcomma
	printString dolar, ldolar
	printVal r12 														; Imprime rt.
	printString retorno, lretorno
	separarR r14 														; Asegurarse de que no se hayan perdido los datos de la instrucción.

	alu 2 																	; suma rax y rcx. resultado en rbx.
	reg_mips r11
	mov [rsi], rbx 													; Mueve resultado a registro mips rd.
	mov ebx, 0
	jmp determinarPC

sumai:	;Tipo I.
	mov r14, rax 														; Mueve instrucción a r14.
	printString sumari, lsumari 						; Imprime mnemonico.
	separarI r14
	printVal r12 														; Imprime rt.
	printString comma, lcomma
	printString dolar, ldolar
	printVal r13 														; Imprime rs.
	printString comma, lcomma
	separarI r14
	printVal r11														; Imprime inmediato.
	printString retorno, lretorno
	separarI r14 														; Asegurarse de que no se hayan perdido los datos de la instrucción.

	reg_mips r13
	mov rax, rdi 														; rax es rs en la alu.
	sign_ext r11
	mov rcx, r11 														; rcx es rt en la alu.
	alu 2
	reg_mips r12
	mov[rsi], rbx
	mov ebx, 0
	jmp determinarPC

sumaiu:	;Tipo I.
	mov r14, rax 														; Mueve instrucción a r14.
	printString sumariu, lsumariu 					; Imprime mnemónico.
	separarI r14
	printVal r12 														; Imprime rt.
	printString comma, lcomma
	printString dolar, ldolar
	printVal r13 														; Imprime rs.
	printString comma, lcomma
	separarI r14
	printVal r11 														; Imprime inmediato.
	printString retorno, lretorno
	separarI r14														; Asegurarse de que no se hayan perdido los datos de la instrucción.

	reg_mips r13
	mov rax, rdi													  ; rax es rs en la alu.
	sign_ext r11
	mov rcx, r11 														; rcx es rt en la alu.
	alu 2
	reg_mips r12
	mov[rsi], rbx
	mov ebx, 0
	jmp determinarPC

y:	;Tipo R.
	printString lalaland, lalalaland 			 ; Imprime mnemónico.
	separarR r14
	printVal r11 													 ; Imprime rd.
	printString comma, lcomma
	printString dolar, ldolar
	printVal r13 													 ; Imprime rs.
	printString comma, lcomma
	printString dolar, ldolar
	printVal r12 													 ; Imprime rt.
	printString retorno, lretorno
	separarR r14 													 ; Asegurarse de que no se hayan perdido los datos de la instrucción.

	alu 0
	reg_mips r11
	mov [rsi], rbx										 		 ; Mueve resultado a registro mips rd.
	mov ebx, 0
	jmp determinarPC

yi:	;Tipo I.
	mov r14, rax 													; Mueve instrucción a r14.
	printString lalalandi, lalalalandi 		; Imprime mnemónico.
	separarI r14
	printVal r12 													; Imprime rt.
	printString comma, lcomma
	printString dolar, ldolar
	printVal r13 													; Imprime rs.
	printString comma, lcomma
	separarI r14
	printVal r11 													; Imprime inmediato.
	printString retorno, lretorno
	separarI r14 													; Asegurarse de que no se hayan perdido los datos de la instrucción.

	reg_mips r13
	mov rax, rdi 											 		; rax es rs en la alu.
	mov rcx, r11													; rcx es rt en la alu.
	alu 0 														 		; and rax y rcx
	reg_mips r12 													; r12 es rt
	mov [rsi], rbx  									 		; Mueve resultado a registro mips rt
	mov ebx, 0
	jmp determinarPC

beq:	;Tipo I.
	mov r14, rax 													; Mueve instrucción a r14.
	printString branchequal, lbranchequal ; Imprime mnemónico.
	separarI r14
	printVal r13 													; Imprime rs.
	printString comma, lcomma
	printString dolar, ldolar
	printVal r12 													; Imprime rt.
	printString comma, lcomma
	separarI r14
	branch_add r11
	printVal r11 													; Imprime branch address.
	printString retorno, lretorno
	separarI r14 													; Asegurarse de que no se hayan perdido los datos de la instrucción.

	reg_mips r13
	mov r13, rdi													;Guarda en rax el contenido de rs
	reg_mips r12
	mov r12, rdi 													;Guarda en rcx el contenido de rt
	cmp r13, r12											 		;Compara si rs y rt son iguales
	je branch_new_addr
	mov ebx, 0
	jmp determinarPC											; si no se cumple, pc+4

bne:	;Tipo I.
	mov r14, rax 													; Mueve instrucción a r14.
	printString branchnequal, lbranchnequal ; Imprime mnemónico.
	separarI r14
	printVal r13												  ; Imprime rs.
	printString comma, lcomma
	printString dolar, ldolar
	printVal r12 													; Imprime rt.
	printString comma, lcomma
	separarI r14
	branch_add r11
	printVal r11  												; Imprime branch address.
	printString retorno, lretorno
	separarI r14 													; Asegurarse de que no se hayan perdido los datos de la instrucción.

	reg_mips r13
	mov r13, rdi													;Guarda en rax el contenido de rs
	reg_mips r12
	mov r12, rdi 													;Guarda en rcx el contenido de rt
	cmp r13, r12													;Compara si rs y rt son iguales
	jne branch_new_addr
	mov ebx, 0
	jmp determinarPC

	;	Si se cumple la condición de alguno de los dos
	;branches, se dirige acá para calcular el nuevo PC.
branch_new_addr:
	separarI rax
	branch_add r11;
	mov ebx, 0;
	mov ebx,r11d
	mov ebx, 0
	jmp determinarPC

j:	;Tipo J.
	mov r14, rax 													; Mueve instrucción a r14.
	printString jump, ljump 							; Imprime mnemónico.
	separarJ r14
	;---------AQUÍ SE IMPRIME EL JUMP ADDRESS, NO EL ADDRESS. Y EN HEXA. -------
	printVal r13 													; Imprime address.
	printString retorno, lretorno
	separarJ r14 													; Asegurarse de que no se hayan perdido los datos de la instrucción.

	mov ebx, 0x00000000
	mov r14, [pc+r15+4]
	and r14d, 0xF0000000
	mov ebx, r14d													; ebx nuevo PC
	shr ebx, 2														;newPC = PC+4[31:28]
	and eax, 0x03FFFFFF
	add ebx, eax
	shl ebx, 2
	jmp determinarPC

jandl:	;Tipo J.
	mov r14, rax 													; Mueve instrucción a r14.
	printString jumpal, ljumpal 					; Imprime mnemónico.
	separarJ r14
	;---------AQUÍ SE IMPRIME EL JUMP ADDRESS, NO EL ADDRESS. Y EN HEXA. -------
	printVal r13 													; Imprime address.
	printString retorno, lretorno
	separarJ r14 													; Asegurarse de que no se hayan perdido los datos de la instrucción.

	mov ebx,0
	mov r14, [pc+r15+4]
	and r14d, 0xF0000000
	mov ebx, r14d 												; ebx nuevo PC
	shl ebx, 26 													; newPC=PC+4[31:28]
	and eax, 0x03FFFFFF
	add ebx, eax
	shl ebx, 2
	jmp determinarPC

jr:	;Tipo R.
	printString jumpreg, ljumpreg 				; Imprime mnemónico.
	separarR r14
	printVal r13													; Imprime rs.
	printString retorno, lretorno
	separarR r14 													; Asegurarse de que no se hayan perdido los datos de la instrucción.

	mov ebx,0
	mov r14, [pc+r15+4]
	and r14d,0xF0000000;
	mov ebx,r14d													; ebx nuevo PC
	shl ebx,26														; newPC=PC+4[31:28]
	and eax,0x03FFFFFF;
	add ebx,eax;
	shl ebx,2;
	jmp determinarPC

lw:	;Tipo I.
	mov r14, rax												  ; Mueve instrucción a r14.
	printString loadw, lloadw 				    ; Imprime mnemonico.
	separarI r14
	printVal r12 												  ; Imprime rt.
	printString comma, lcomma
	separarI r14
	printVal r11 												  ; Imprime inmediato.
	printString parentizq, lparentizq
	printString dolar, ldolar
	printVal r13 													; Imprime rs.
	printString parentder, lparentder
	printString retorno, lretorno
	separarI r14 													; Asegurarse de que no se hayan perdido los datos de la instrucción.

	sign_ext r11													;Se toma el inmediato y se extiende el signo
	reg_mips r13
	mov r13, rdi													;se utiliza la macro para obtener el valor y dirección de Rs
	add r13, r11													;se suman ambos valores para calcular la dirección de memoria
	cmp r13, 99
	ja memoverflow
	mov rax, 4														;se multiplica por 4 ya que la memoria se divide en bytes (palabras de 4*8bits)
	mul r13
	add rax, datos 												;se suma a datos ya que es el valor inicial de memoria de datos en el computador real
	mov rax, [rax]												;se toma ese valor de memoria y se guarda de nuevo en rax
	reg_mips r12
	mov [rsi], rax												;se guarda el valor sacado de memoria de datos al registro destino Rt
	mov ebx, 0
	jmp determinarPC

mult:	;Tipo R.
	printString multiplicar, lmultiplicar ; Imprime mnemonico.
	separarR r14
	printVal r13 													; Imprime rs.
	printString comma, lcomma
	printString dolar, ldolar
	printVal r12 													; Imprime rt.
	printString retorno, lretorno
	separarR r14 													; Asegurarse de que no se hayan perdido los datos de la instrucción.

	alu 6
	mov [resmult], rbx 										; Mueve resultado a registro de 64 bits.
	mov ebx, 0
	jmp determinarPC

nor:	;Tipo R.
	printString nordico, lnordico					; Imprime mnemonico.
	separarR r14
	printVal r11 													; Imprime rd.
	printString comma, lcomma
	printString dolar, ldolar
	printVal r13													; Imprime rs.
	printString comma, lcomma
	printString dolar, ldolar
	printVal r12 													; Imprime rt.
	printString retorno, lretorno
	separarR r14 													; Asegurarse de que no se hayan perdido los datos de la instrucción.

	alu 5
	reg_mips r11
	mov [rsi], rbx 												; Mueve resultado a registro mips rd.
	mov ebx, 0
	jmp determinarPC

o:	;Tipo R.
	printString orcito, lorcito 					; Imprime mnemonico.
	separarR r14
	printVal r11 													; Imprime rd.
	printString comma, lcomma
	printString dolar, ldolar
	printVal r13 													; Imprime rs.
	printString comma, lcomma
	printString dolar, ldolar
	printVal r12 													; Imprime rt.
	printString retorno, lretorno
	separarR r14 													; Asegurarse de que no se hayan perdido los datos de la instrucción.

	alu 1
	reg_mips r11
	mov [rsi], rbx 												; Mueve resultado a registro mips rd.
	mov ebx, 0
	jmp determinarPC

ori:	;Tipo I.
	mov r14, rax 													; Mueve instrucción a r14.
	printString oricito, loricito 				; Imprime mnemonico.
	separarI r14
	printVal r12 													; Imprime rt.
	printString comma, lcomma
	printString dolar, ldolar
	printVal r13													; Imprime rs.
	printString comma, lcomma
	separarI r14
	printVal r11 													; Imprime inmediato.
	printString retorno, lretorno
	separarI r14 													; Asegurarse de que no se hayan perdido los datos de la instrucción.

	reg_mips r13
	mov rax, rdi 													; rax es rs en la alu.
	mov rcx, r11 													; rcx es rt en la alu.
	alu 1 																; or entre rax y rcx
	reg_mips r12 													; r12 es rt
	mov [rsi], rbx 												; Mueve resultado a registro mips rt
	mov ebx, 0
	jmp determinarPC

slt:	;Tipo R.
	printString slthan, lslthan 					; Imprime mnemonico.
	separarR r14
	printVal r11 													; Imprime rd.
	printString comma, lcomma
	printString dolar, ldolar
	printVal r13 													; Imprime rs.
	printString comma, lcomma
	printString dolar, ldolar
	printVal r12 													; Imprime rt.
	printString retorno, lretorno
	separarR r14 													; Asegurarse de que no se hayan perdido los datos de la instrucción.

	alu 4
	reg_mips r11
	mov [rsi], rbx												; Mueve resultado a registro mips rd.
	mov ebx, 0
	jmp determinarPC

sltu:	;Tipo R.
	printString slthanu, lslthanu					; Imprime mnemonico.
	separarR r14
	printVal r11 													; Imprime rd.
	printString comma, lcomma
	printString dolar, ldolar
	printVal r13 													; Imprime rs.
	printString comma, lcomma
	printString dolar, ldolar
	printVal r12 													; Imprime rt.
	printString retorno, lretorno
	separarR r14													; Asegurarse de que no se hayan perdido los datos de la instrucción.

	alu 4
	reg_mips r11
	mov [rsi], rbx 												; Mueve resultado a registro mips rd.
	mov ebx, 0
	jmp determinarPC

slti:	;Tipo I.
	mov r14, rax 													; Mueve instrucción a r14.
	printString slthani, lslthani 				; Imprime mnemonico.
	separarI r14
	printVal r12													; Imprime rt.
	printString comma, lcomma
	printString dolar, ldolar
	printVal r13 													; Imprimer rs.
	printString comma, lcomma
	separarI r14
	printVal r11 													; Imprime inmediato.
	printString retorno, lretorno
	separarI r14 													; Asegurarse de que no se hayan perdido los datos de la instrucción.

	reg_mips r13
	mov rax, rdi 													; rax es rs en la alu.
	sign_ext r11
	mov rcx, r11													; rcx es rt en la alu.
	alu 4
	reg_mips r12
	mov [rsi], rbx												; Mueve resultado a registro mips rd.
	mov ebx, 0
	jmp determinarPC

sltiu:	;Tipo I.
	mov r14, rax 													; Mueve instrucción a r14.
	printString slthaniu, lslthaniu 			; Imprime mnemonico.
	separarI r14
	printVal r12 													; Imprime rt.
	printString comma, lcomma
	printString dolar, ldolar
	printVal r13 													; Imprimer rs.
	printString comma, lcomma
	separarI r14
	printVal r11 													; Imprime inmediato.
	printString retorno, lretorno
	separarI r14 													; Asegurarse de que no se hayan perdido los datos de la instrucción.

	reg_mips r13
	mov rax, rdi													; rax es rs en la alu.
	sign_ext r11
	mov rcx, r11													; rcx es rt en la alu.
	alu 4
	reg_mips r12
	mov [rsi], rbx												; Mueve resultado a registro mips rd.
	mov ebx, 0
	jmp determinarPC

sll:	;Tipo R.
	printString shiftl, lshiftl 					; Imprime mnemonico.
	separarR r14
	printVal r11 													; Imprime rd.
	printString comma, lcomma
	printString dolar, ldolar
	printVal r12 													; Imprime rt.
	printString comma, lcomma
	printVal r10 													; Imprime shamt.
	printString retorno, lretorno
	separarR r14 													; Asegurarse de que no se hayan perdido los datos de la instrucción.

	reg_mips r12
	mov r8, rdi														; En r8 dato a correr.
	mov rcx, r10													; En rcx shamt.
	shl r8, cl														; Corrimiento según el shamt.
	reg_mips r11
	mov [rsi], r8													; Mueve resultado a rd.
	mov ebx, 0
	jmp determinarPC

srl:	;Tipo R.
	printString shiftr, lshiftr						; Imprime mnemonico.
	separarR r14
	printVal r11 													; Imprime rd.
	printString comma, lcomma
	printString dolar, ldolar
	printVal r12 													; Imprime rt.
	printString comma, lcomma
	printVal r10 													; Imprime shamt.
	printString retorno, lretorno
	separarR r14 													; Asegurarse de que no se hayan perdido los datos de la instrucción.

	reg_mips r12
	mov r8, rdi														; En r8 dato a correr.
	mov rcx, r10													; En rcx shamt.
	shr r8, cl														; Corrimiento según el shamt.
	reg_mips r11
	mov [rsi], r8 												; Mueve resultado a rd.
	mov ebx, 0
	jmp determinarPC

resta:	;Tipo R.
	printString restar, lrestar						; Imprime mnemonico.
	separarR r14
	printVal r11 													; Imprime rd.
	printString comma, lcomma
	printString dolar, ldolar
	printVal r13 													; Imprime rs.
	printString comma, lcomma
	printString dolar, ldolar
	printVal r12 													; Imprime rt.
	printString retorno, lretorno
	separarR r14 													; Asegurarse de que no se hayan perdido los datos de la instrucción.

	alu 3
	reg_mips r11
	mov [rsi], rbx 												; Mueve resultado a registro mips rd.
	mov ebx, 0
	jmp determinarPC

restau:	;Tipo R.
	printString restaru, lrestaru					; Imprime mnemonico.
	separarR r14
	printVal r11 													; Imprime rd.
	printString comma, lcomma
	printString dolar, ldolar
	printVal r13 													; Imprime rs.
	printString comma, lcomma
	printString dolar, ldolar
	printVal r12 													; Imprime rt.
	printString retorno, lretorno
	separarR r14 													; Asegurarse de que no se hayan perdido los datos de la instrucción.

	alu 3
	reg_mips r11
	mov [rsi], rbx 												; Mueve resultado a registro mips rd.
	mov ebx, 0
	jmp determinarPC

sw:	;Tipo I.
	mov r14, rax												 ; Mueve instrucción a r14.
	printString storew, lstorew 				 ; Imprime mnemonico.
	separarI r14
	printVal r12 												 ; Imprime rt.
	printString comma, lcomma
	separarI r14
	printVal r11 												 ; Imprime inmediato.
	printString parentizq, lparentizq
	printString dolar, ldolar
	printVal r13 												 ; Imprime rs.
	printString parentder, lparentder
	printString retorno, lretorno
	separarI r14 												 ; Asegurarse de que no se hayan perdido los datos de la instrucción.

	sign_ext r11												 ;Se toma el inmediato y se extiende el signo
	reg_mips r13												 ;se utiliza la macro para obtener el valor y dirección de Rs
	mov r13, rdi
	add r13, r11  											 ;se suman ambos valores para calcular la dirección de memoria
	cmp r13, 99
	ja memoverflow											 ;si se sobrepasa de las 100 palabras de memoria, imprime mensaje de error.
	mov rax, 4
	mul r13															 ;se multiplica por 4 ya que la memoria se divide en bytes (palabras de 4*8bits)
	add rax, datos 											 ;se suma a datos ya que es el valor inicial de memoria de datos en el computador real.
	reg_mips r12
	mov [rax], rdi											 ;se toma el valor de rt y se guarda en la dirección calculada en rax
	mov ebx, 0
	jmp determinarPC

; -------------------- Error de dirección de memoria no encontrada --------------------
memoverflow:
	printString memmax, lmemmax


; -------------------- Error de instruccíon no encontrada --------------------
instnotfound:
	printString nfound, lnfound
	exit
;	jmp determinarPC

; -------------------- Imprimir registros --------------------


; -------------------- Obtener datos del microprocesador --------------------
datosMicro:

 ;Esta sección permite obtener información del fabricante del procesador


	mov eax,80000002h
	cpuid
	mov [datosCPU], eax
	mov [datosCPU+4], ebx
	mov [datosCPU+8], ecx
	mov [datosCPU+12], edx

	;Esta sección permite obtener información del micro

	mov eax,80000003h
	cpuid
	mov [datosCPU+16], eax
	mov [datosCPU+20], ebx
	mov [datosCPU+24], ecx
	mov [datosCPU+28], edx


	mov eax,80000004h
	cpuid
	mov [datosCPU+32], eax
	mov [datosCPU+36], ebx
	mov [datosCPU+40], ecx
	mov [datosCPU+44], edx

	printString datosCPU, 48
	;printString retorno, lretorno

; -------------------- Lectura de Enter para finalizar la ejecución --------------------
presionaEnter:
		readString teclado,1
		mov r15, [teclado]
		cmp r15, 0xa
		jne presionaEnter
