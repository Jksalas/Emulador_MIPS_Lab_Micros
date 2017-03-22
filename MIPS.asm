;########################################################################
;	Instituto Tecnológico de Costa Rica - Escuela de Ingeniería Electrónica
;	Curso: Laboratorio de Estructura de Microprocesadores - Grupo 1
;	Fecha: Miércoles 22 de marzo del 2017
;	Proyecto #1: Emulador MIPS
;
;	Realizado por:
;		- Camila Gómez Molina
;		- Steven León Domínguez
;		- André Martínez Arana
;		- Joao Salas Ramírez
;		- Juan José Vásquez Alfaro
;########################################################################


%include "macros.inc"

; -------------------- Sección del código principal --------------------
section .text

	global _start

_start:

; -------------------------- Recibir argumentos -------------------------

	mov rax, 0
	mov r14, 0
	mov [argPos], rax

	pop rax
	mov [argc], rax


;----------------------Inicializa el stack pointer-----------------------

		mov r8d, [stack1];
		mov [reg29], r8d;

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

; --------------------- Asignar argumentos a registros --------------------

argumento1:
	DeterminarArgumento r8 																				; Guardar en r8 el primer argumento
argumento2:
	DeterminarArgumento r9 																				; Guardar en r9 el segundo argumento
argumento3:
	DeterminarArgumento r10																				; Guardar en r10 el tercer argumento
argumento4:
	DeterminarArgumento r11																				; Guardar en r11 el cuarto argumento

seguir:
	inc byte[m]
	mov rax, [argPos]
	mov rbx, [argc]
	cmp rax, rbx
	jne _printArgsLoop

; Se guarda en r8, r9, r10 y r11 los argumentos de $a0, $a1, $a2 y $a3 respectivamente

	mov [reg4],r8
	mov [reg5],r9
	mov [reg6],r10
	mov [reg7],r11

	; --------------------------- Lectura de ROM.txt ---------------------------

		mov rax, 0
		mov rbx, 0
		mov rcx, 0
		mov edx, 0
		mov r8, 0
		mov r9, 0
		mov r10, 0
		mov r11, 0
		mov r12, 0
		mov r13, 0
		mov r14, 0
		mov r15, 0

	; ----------------------------- Abrir ROM.txt ------------------------------
		mov ebx, file 																								; nombre del archivo
		mov eax, 5
		mov ecx, 0
		int 80h

		mov eax, 3
		mov ebx, eax
		mov ecx, buffer
		mov edx, len
		int 80h

; -------------------- Imprimir mensajes de bienvenida --------------------
;Se crea el archivo Resultados.txt
	mov rax,2                           ;sys_open; en caso de acierto el fd queda en rax
	mov rdi,cons_Resultadostxt          ;se creara el archivo ROM.txt
	mov rsi,(2000o+1000o+100o+2o)       ;bandera se creara o se truncara a 0 y se usara en modo append
	mov rdx,(700o+40o+4o)               ;permisos
	syscall
	mov [Resultadostxt],rax		;se respalda el fd del archivo de resultados

	cleanScreen cleanS, cleanS_size
	printString bienvenido,lbienvenido 														;Bienvenida
	printString lab, llab																					;Datos del curso
	printString sem, lsem																					;Semestre
	printString retorno, lretorno
	printString buscando, lbuscando																;Msj buscando ROM.txt


; ------------------------- Pasar de Ascii a entero -----------------------
	mov r8, [buffer]
	cmp r8, 0																											; Si el primer bit de la lectura es un cero, quiere decir que no está leyendo ROM.txt
	je errorcito																									;	Si no está leyendo ROM.txt brinca a errorcito
	printString encuentra, lencuentra															; Si la leyó, imprime msj diciendo que se ha encontrado la ROM
	printString retorno, lretorno
	printString mensajeinicio, lmensajeinicio											; Imprime msj presionar enter para continuar la ejecución
	jmp presionaEnterC
	holi:
	mov rax, 0																										; Libera los registros
	mov rbx, 0
	mov r15, 0
	jmp loop1
	errorcito:
			printString noencuentra, lnoencuentra											; Imprime msj para informar que se encontró la ROM
			printString theend, ltheend																; Imprime msj presionar enter para terminar ejecución
			jmp presionaEnter

loop1:																													; Loop que permite convertir de ascii a entero
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

; -------------------------- Guardar PC en memoria ------------------------
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

; --------------------------- Guardar en memoria --------------------------
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
_break99:
	mov r8d, eax
	not r8d
	inc r8
	add r15, r8
	mov eax, [trama+r15]
	jmp inicio

finLectura:
	mov ebx, 0;
	mov r15, 0;
	mov r8, trama

inicio:
	mov eax, [trama+r15]

	mov ebx, [pc+r15]
	cmp rax, 0
	je L7
	jmp L8
L7:
	mov ecx, [pc+r15]
	cmp ecx, 0
	je gameover
	mov ebx, 0
	mov ecx,0
	jmp determinarPC
L8:
	separarJ rax
	jmp decode

  mov eax, 1
  mov ebx, 0
  int 80h

; ------------------------------ Decodificación ---------------------------

decode:

	cmp r14, 000000b                        ; Compara con 0 para ver si es una instrucción tipo R
	je R			                              ; En caso de serlo, salta a R
	cmp r14, 001000b                        ; Compara con addi
	je sumai                                ; Salta a .sumai
	cmp r14, 001001b                        ; Compara con addiu
	je sumaiu               	              ; Salta a .sumaiu
	cmp r14, 001100b    		                ; Compara con andi
	je yi            		                    ; Salta a .y
	cmp r14, 000100b                		    ; Compara con beq
	je beq                      		        ; Salta a .beq
	cmp r14, 000101b        		            ; Compara con bne
	je bne              		                ; Salta a .bne
	cmp r14, 000010b 		                    ; Compara con j
	je j                		                ; Salta a .j
	cmp r14, 000011b                		    ; Compara con jal
	je jandl                    		        ; Salta a .jandl
	cmp r14, 100011b 		                    ; Compara con lw
	je lw                             		  ; Salta a .lw
	cmp r14, 001101b              		      ; Compara con ori
	je ori                    		          ; Salta a .ori
	cmp r14, 001010b                  		  ; Compara con slti
	je slti                       		      ; Salta a .slti
	cmp r14, 001011b          		          ; Compara con sltiu
	je sltiu              		              ; Salta a .sltiu
	cmp r14, 101011b          		          ; Compara con sw
	je sw                 		              ; Salta a .sw
	jmp instnotfound 			                  ; Si la instrucción no se encuentra en el set que maneja el procesador
		                                      ; Se ejecuta una rutina que lo informa en pantalla

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
	cmp ebx, 0 															; Si el PC actual es 0, significa lí­nea en blanco. Este será el fin del programa.
	je gameover 														; Fin del programa.
	jmp instnotfound                    		;si la instrucción no se
		                                      ;encuentra en el set que maneja el procesador
		                                      ;Se ejecuta una rutina que lo informa en pantalla

; ---------------- Rutinas correspondientes a cada instrucción ---------------

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
	shl rbx, 32
	shr rbx, 32															; Asegurarse que el resultado sea de 32 bits.
	reg_mips r11
	mov [rsi], ebx 													; Mueve resultado a registro mips rd.
	ImprimirRegistros												; Imprime contenido de los registros ao-a3, vo-v1, s0-s7
	mov ebx, 0
	jmp determinarPC

sumau:	;Tipo R.
	printString sumaru, lsumaru 						 ; Imprime mnemónico.
	separarR r14
	printVal r11 														 ; Imprime rd.
	printString comma, lcomma
	printString dolar, ldolar
	printVal r13 														 ; Imprime rs.
	printString comma, lcomma
	printString dolar, ldolar
	printVal r12 														 ; Imprime rt.
	printString retorno, lretorno
	separarR r14 														 ; Asegurarse de que no se hayan perdido los datos de la instrucción.

	alu 2 																	 ; Suma rax y rcx. resultado en rbx.
	shl rbx, 32
	shr rbx, 32															 ; Asegurarse que el resultado sea de 32 bits.
	reg_mips r11
	mov [rsi], ebx 													 ; Mueve resultado a registro mips rd.
	ImprimirRegistros												 ; Imprime contenido de los registros ao-a3, vo-v1, s0-s7
	mov ebx, 0
	jmp determinarPC

sumai:	;Tipo I.
	mov r14, rax 														 ; Mueve instrucción a r14.
	printString sumari, lsumari 						 ; Imprime mnemonico.
	separarI r14
	printVal r12 													   ; Imprime rt.
	printString comma, lcomma
	printString dolar, ldolar
	printVal r13 														 ; Imprime rs.
	printString comma, lcomma
	separarI r14
	printVal r11														 ; Imprime inmediato.
	printString retorno, lretorno
	separarI r14 														 ; Asegurarse de que no se hayan perdido los datos de la instrucción.

	reg_mips r13
	mov rax, rdi 														 ; rax es rs en la alu.
	shl rax, 32
	shr rax, 32															 ; Cortar dato a 32 bits.
	sign_ext r11
	mov rcx, r11 														 ; rcx es rt en la alu.
	alu 2
	shl rbx, 32
	shr rbx, 32															 ; Asegurarse que el resultado sea de 32 bits.
	reg_mips r12
	mov [rsi], ebx
	ImprimirRegistros												 ; Imprime contenido de los registros ao-a3, vo-v1, s0-s7
	mov ebx, 0
	jmp determinarPC

sumaiu:	;Tipo I.
	mov r14, rax 														 ; Mueve instrucción a r14.
	printString sumariu, lsumariu 					 ; Imprime mnemónico.
	separarI r14
	printVal r12 														 ; Imprime rt.
	printString comma, lcomma
	printString dolar, ldolar
	printVal r13 														 ; Imprime rs.
	printString comma, lcomma
	separarI r14
	printVal r11 														 ; Imprime inmediato.
	printString retorno, lretorno
	separarI r14														 ; Asegurarse de que no se hayan perdido los datos de la instrucción.

	reg_mips r13
	mov rax, rdi													   ; rax es rs en la alu.
	shl rax, 32
	shr rax, 32															 ; Cortar dato a 32 bits.
	sign_ext r11
	mov rcx, r11 														 ; rcx es rt en la alu.
	alu 2
	shl rbx, 32
	shr rbx, 32															 ; Asegurarse que el resultado sea de 32 bits.
	reg_mips r12
	mov[rsi], ebx
	ImprimirRegistros												 ; Imprime contenido de los registros ao-a3, vo-v1, s0-s7
	mov ebx, 0
	jmp determinarPC

y:	;Tipo R.
	printString lalaland, lalalaland 			 	 ; Imprime mnemónico.
	separarR r14
	printVal r11 														 ; Imprime rd.
	printString comma, lcomma
	printString dolar, ldolar
	printVal r13 														 ; Imprime rs.
	printString comma, lcomma
	printString dolar, ldolar
	printVal r12 														 ; Imprime rt.
	printString retorno, lretorno
	separarR r14 														 ; Asegurarse de que no se hayan perdido los datos de la instrucción.

	alu 0
	shl rbx, 32
	shr rbx, 32															 ; Asegurarse que el resultado sea de 32 bits.
	reg_mips r11
	mov [rsi], ebx										 			 ; Mueve resultado a registro mips rd.
	ImprimirRegistros												 ; Imprime contenido de los registros ao-a3, vo-v1, s0-s7
	mov ebx, 0
	jmp determinarPC

yi:	;Tipo I.
	mov r14, rax 														 ; Mueve instrucción a r14.
	printString lalalandi, lalalalandi 	     ; Imprime mnemónico.
	separarI r14
	printVal r12 													   ; Imprime rt.
	printString comma, lcomma
	printString dolar, ldolar
	printVal r13 													   ; Imprime rs.
	printString comma, lcomma
	separarI r14
	printVal r11 													   ; Imprime inmediato.
	printString retorno, lretorno
	separarI r14 													   ; Asegurarse de que no se hayan perdido los datos de la instrucción.

	reg_mips r13
	mov rax, rdi 											 		   ; rax es rs en la alu.
	shl rax, 32
	shr rax, 32															 ; Cortar dato a 32 bits.
	mov rcx, r11													   ; rcx es rt en la alu.
	alu 0 														 		   ; and rax y rcx
	shl rbx, 32
	shr rbx, 32															 ; Asegurarse que el resultado sea de 32 bits.
	reg_mips r12 													   ; r12 es rt
	mov [rsi], ebx  									 		   ; Mueve resultado a registro mips rt
	ImprimirRegistros												 ; Imprime contenido de los registros ao-a3, vo-v1, s0-s7
	mov ebx, 0
	jmp determinarPC

beq:	;Tipo I.
	mov r14, rax 													   ; Mueve instrucción a r14.
	mov r8, rbx
	printString branchequal, lbranchequal    ; Imprime mnemónico.
	separarI r14
	printVal r13 													   ; Imprime rs.
	printString comma, lcomma
	printString dolar, ldolar
	printVal r12 													   ; Imprime rt.
	printString comma, lcomma
	separarI r14
	branch_add r11
	printVal r11 												     ; Imprime branch address.
	printString retorno, lretorno
	separarI r14 													   ; Asegurarse de que no se hayan perdido los datos de la instrucción.

	reg_mips r13
	mov r13, rdi													   ; Guarda en rax el contenido de rs
	shl r13, 32
	shr r13, 32														   ; Cortar dato a 32 bits.
	reg_mips r12
	mov r12, rdi 													   ; Guarda en rcx el contenido de rt
	shl r12, 32
	shr r12, 32														   ; Cortar dato a 32 bits.
	cmp r13, r12											 		   ; Compara si rs y rt son iguales
	je branch_new_addr
	ImprimirRegistros												 ; Imprime contenido de los registros ao-a3, vo-v1, s0-s7
	mov ebx, 0
	jmp determinarPC											   ; Si no se cumple, pc+4

bne:	;Tipo I.
	mov r14, rax 													   ; Mueve instrucción a r14.
	mov r8, rbx
	printString branchnequal, lbranchnequal  ; Imprime mnemónico.
	separarI r14
	printVal r13												     ; Imprime rs.
	printString comma, lcomma
	printString dolar, ldolar
	printVal r12 													   ; Imprime rt.
	printString comma, lcomma
	separarI r14
	branch_add r11
	printVal r11  												   ; Imprime branch address.
	printString retorno, lretorno
	separarI r14 													   ; Asegurarse de que no se hayan perdido los datos de la instrucción.

	reg_mips r13
	mov r13, rdi													   ; Guarda en rax el contenido de rs
	shl r13, 32
	shr r13, 32														   ; Cortar dato a 32 bits.
	reg_mips r12
	mov r12, rdi 													   ; Guarda en rcx el contenido de rt
	shl r12, 32
	shr r12, 32														   ; Cortar dato a 32 bits.
	cmp r13, r12													   ; Compara si rs y rt son iguales
	jne branch_new_addr
	ImprimirRegistros							  				 ; Imprime contenido de los registros ao-a3, vo-v1, s0-s7
	mov ebx, 0
	jmp determinarPC

;	Si se cumple la condición de alguno de los dosbranches, se dirige acá para calcular el nuevo PC.
branch_new_addr:
	separarI r14
	branch_add r11
	add r11, r8
	mov ebx, 0
	mov ebx,r11d
	mov r8d, ebx
	ImprimirRegistros 											 ; Imprime contenido de los registros ao-a3, vo-v1, s0-s7
	mov ebx,r8d
	jmp determinarPC

j:	;Tipo J.
_break1:
	mov r12, rax 													   ; Mueve instrucción a r14.
	printString jump, ljump 							   ; Imprime mnemónico.
	separarJ r12
	;--------- Aquí se imprime en hexa el Jump Addres, no el Addres -------
	printVal r13 													   ; Imprime address.
	printString retorno, lretorno
	separarJ r12 													   ; Asegurarse de que no se hayan perdido los datos de la instrucción.

	mov ebx,0x00000000								       ; ebx registro utilizado para guardar la nueva direccion del PC
	add r14d,r15d											  	   ; PC_actual=PC+4;
	and r14d,0xF0000000;
	mov ebx,r14d;											  	   ; Se carga en ebx los bits mas significativos del PC_actual
	shr ebx,2													  	   ; newPC = PC+4[31:28]
	add ebx,r13d
	shl ebx,2;														   ;Address final luego del cálculo
	mov r8d, ebx
	ImprimirRegistros												 ; Imprime contenido de los registros ao-a3, vo-v1, s0-s7
	mov ebx,r8d
	jmp determinarPC

jandl: ;Tipo J.
_break4545:
	mov r12, rax 													   ; Mueve instrucción a r14.
	printString jumpal, ljumpal 					   ; Imprime mnemónico.
	separarJ r12

	;--------- Aquí se imprime en hexa el Jump Addres, no el Addres -------

	printVal r13 													   ; Imprime address.
	printString retorno, lretorno
	separarJ r12 													   ; Asegurarse de que no se hayan perdido los datos de la instrucción.

	mov ebx,0x00000000									     ; ebx registro utilizado para guardar la nueva direccion del PC
	add r14d,r15d												     ; PC_actual=PC+4;
	mov r11d, r14d
	and r14d,0xF0000000;
	mov ebx,r14d;												     ; Se carga en ebx los bits mas significativos del PC_actual
	shr ebx,2														     ; newPC = PC+4[31:28]
	add ebx,r13d
	shl ebx,2;														   ; Address final luego del cálculo
	mov r8d, ebx
	add r11d, r15d
	mov eax,[pc+r15+8]											 ; PC + 8
	mov [reg31], eax
	ImprimirRegistros												 ; Imprime contenido de los registros ao-a3, vo-v1, s0-s7
	mov ebx, r8d
	jmp determinarPC

jr:	;Tipo R.
_break100:
	printString jumpreg, ljumpreg 			    ; Imprime mnemónico.
	separarR r14
	printVal r13												  	; Imprime rs.
	printString retorno, lretorno
	separarR r14 													  ; Asegurarse de que no se hayan perdido los datos de la instrucción.

	cmp r13, 31
	jne invaliddir	                        ; Si el reg que se está llamando no es el 31 (return address), hay error.
	reg_mips r13
	cmp rdi, 0x0000000000000000
  je invaliddirR

	mov r8d, edi	                          ; Carga en ebx la dirección que está en el registro solicitado.
	ImprimirRegistros												; Imprime contenido de los registros ao-a3, vo-v1, s0-s7
	mov ebx,r8d
	jmp determinarPC

lw:	;Tipo I.
	mov r14, rax												    ; Mueve instrucción a r14.
	printString loadw, lloadw 				      ; Imprime mnemonico.
	separarI r14
	printVal r12 												    ; Imprime rt.
	printString comma, lcomma
	separarI r14
	printVal r11 												    ; Imprime inmediato.
	printString parentizq, lparentizq
	printString dolar, ldolar
	printVal r13 													  ; Imprime rs.
	printString parentder, lparentder
	printString retorno, lretorno
	separarI r14 													  ; Asegurarse de que no se hayan perdido los datos de la instrucción.

	sign_ext r11													  ; Se toma el inmediato y se extiende el signo
	reg_mips r13
	mov r13, rdi													  ; Se utiliza la macro para obtener el valor y dirección de Rs
	shl r13, 32
	shr r13, 32															; Cortar dato a 32 bits.
	add r13, r11													  ; Se suman ambos valores para calcular la dirección de memoria
	cmp r13, 99
	ja memoverflow
	mov rax, 4														  ; Se multiplica por 4 ya que la memoria se divide en bytes (palabras de 4*8bits)
	mul r13
	add rax, datos 												  ; Se suma a datos ya que es el valor inicial de memoria de datos en el computador real
	mov rax, [rax]												  ; Se toma ese valor de memoria y se guarda de nuevo en rax
	reg_mips r12
	mov [rsi], eax												  ; Se guarda el valor sacado de memoria de datos al registro destino Rt
	ImprimirRegistros												; Imprime contenido de los registros ao-a3, vo-v1, s0-s7
	mov r9,rsi
	cmp rsi, reg29
	je stackout
	reg_mips r13
	cmp rsi, reg29
	je stackout
vuelvestack:
	mov ebx, 0
	jmp determinarPC

stackout:    ;POP
	mov r8,[reg29];
	;mov [r9d],[stack1+r8]; pop de pila
	jmp vuelvestack

mult:	;Tipo R.
	printString multiplicar, lmultiplicar   ; Imprime mnemonico.
	separarR r14
	printVal r13 													  ; Imprime rs.
	printString comma, lcomma
	printString dolar, ldolar
	printVal r12 													  ; Imprime rt.
	printString retorno, lretorno
	separarR r14 													  ; Asegurarse de que no se hayan perdido los datos de la instrucción.

	alu 6
	mov [resmult], rbx 										  ; Mueve resultado a registro de 64 bits.
	ImprimirRegistros												; Imprime contenido de los registros ao-a3, vo-v1, s0-s7
	mov ebx, 0
	jmp determinarPC

nor:	;Tipo R.
	printString nordico, lnordico					  ; Imprime mnemonico.
	separarR r14
	printVal r11 													  ; Imprime rd.
	printString comma, lcomma
	printString dolar, ldolar
	printVal r13													  ; Imprime rs.
	printString comma, lcomma
	printString dolar, ldolar
	printVal r12 													  ; Imprime rt.
	printString retorno, lretorno
	separarR r14 													  ; Asegurarse de que no se hayan perdido los datos de la instrucción.

	alu 5
	shl rbx, 32
	shr rbx, 32														  ; Asegurarse que el resultado sea de 32 bits.
	reg_mips r11
	mov [rsi], ebx 												  ; Mueve resultado a registro mips rd.
	ImprimirRegistros												; Imprime contenido de los registros ao-a3, vo-v1, s0-s7
	mov ebx, 0
	jmp determinarPC

o:	;Tipo R.
	printString orcito, lorcito 				    ; Imprime mnemonico.
	separarR r14
	printVal r11 													  ; Imprime rd.
	printString comma, lcomma
	printString dolar, ldolar
	printVal r13 													  ; Imprime rs.
	printString comma, lcomma
	printString dolar, ldolar
	printVal r12 													  ; Imprime rt.
	printString retorno, lretorno
	separarR r14 													  ; Asegurarse de que no se hayan perdido los datos de la instrucción.

	alu 1
	shl rbx, 32
	shr rbx, 32															; Asegurarse que el resultado sea de 32 bits.
	reg_mips r11
	mov [rsi], ebx 												  ; Mueve resultado a registro mips rd.
	ImprimirRegistros												; Imprime contenido de los registros ao-a3, vo-v1, s0-s7
	mov ebx, 0
	jmp determinarPC

ori:	;Tipo I.
	mov r14, rax 													  ; Mueve instrucción a r14.
	printString oricito, loricito 				  ; Imprime mnemonico.
	separarI r14
	printVal r12 													  ; Imprime rt.
	printString comma, lcomma
	printString dolar, ldolar
	printVal r13													  ; Imprime rs.
	printString comma, lcomma
	separarI r14
	printVal r11 													  ; Imprime inmediato.
	printString retorno, lretorno
	separarI r14 													  ; Asegurarse de que no se hayan perdido los datos de la instrucción.

	reg_mips r13
	mov rax, rdi 													  ; Rax es rs en la alu.
	shl rax, 32
	shr rax, 32															; Cortar dato a 32 bits.
	mov rcx, r11 													  ; Rcx es rt en la alu.
	alu 1 																  ; Or entre rax y rcx
	shl rbx, 32
	shr rbx, 32														  ; Asegurarse que el resultado sea de 32 bits.
	reg_mips r12 													  ; R12 es rt
	mov [rsi], ebx 												  ; Mueve resultado a registro mips rt
	ImprimirRegistros												; Imprime contenido de los registros ao-a3, vo-v1, s0-s7
	mov ebx, 0
	jmp determinarPC

slt:	;Tipo R.
	printString slthan, lslthan 					  ; Imprime mnemonico.
	separarR r14
	printVal r11 													  ; Imprime rd.
	printString comma, lcomma
	printString dolar, ldolar
	printVal r13 													  ; Imprime rs.
	printString comma, lcomma
	printString dolar, ldolar
	printVal r12 													  ; Imprime rt.
	printString retorno, lretorno
	separarR r14 													  ; Asegurarse de que no se hayan perdido los datos de la instrucción.

	alu 4
	shl rbx, 32
	shr rbx, 32															; Asegurarse que el resultado sea de 32 bits.
	reg_mips r11
	mov [rsi], ebx												  ; Mueve resultado a registro mips rd.
	ImprimirRegistros												; Imprime contenido de los registros ao-a3, vo-v1, s0-s7
	mov ebx, 0
	jmp determinarPC

sltu:	;Tipo R.
	printString slthanu, lslthanu					  ; Imprime mnemonico.
	separarR r14
	printVal r11 													  ; Imprime rd.
	printString comma, lcomma
	printString dolar, ldolar
	printVal r13 													  ; Imprime rs.
	printString comma, lcomma
	printString dolar, ldolar
	printVal r12 													  ; Imprime rt.
	printString retorno, lretorno
	separarR r14													  ; Asegurarse de que no se hayan perdido los datos de la instrucción.

	alu 4
	shl rbx, 32
	shr rbx, 32															; Asegurarse que el resultado sea de 32 bits.
	reg_mips r11
	mov [rsi], ebx 												  ; Mueve resultado a registro mips rd.
	ImprimirRegistros												; Imprime contenido de los registros ao-a3, vo-v1, s0-s7
	mov ebx, 0
	jmp determinarPC

slti:	;Tipo I.
	mov r14, rax 													  ; Mueve instrucción a r14.
	printString slthani, lslthani 				  ; Imprime mnemonico.
	separarI r14
	printVal r12													  ; Imprime rt.
	printString comma, lcomma
	printString dolar, ldolar
	printVal r13 												  	; Imprimer rs.
	printString comma, lcomma
	separarI r14
	printVal r11 													  ; Imprime inmediato.
	printString retorno, lretorno
	separarI r14 													  ; Asegurarse de que no se hayan perdido los datos de la instrucción.

	reg_mips r13
	mov rax, rdi 													  ; Rax es rs en la alu.
	shl rax, 32
	shr rax, 32															; Cortar dato a 32 bits.
	sign_ext r11
	mov rcx, r11												  	; Rcx es rt en la alu.
	alu 4
	shl rbx, 32
	shr rbx, 32															; Asegurarse que el resultado sea de 32 bits.
	reg_mips r12
	mov [rsi], ebx												  ; Mueve resultado a registro mips rd.
	ImprimirRegistros												; Imprime contenido de los registros ao-a3, vo-v1, s0-s7
	mov ebx, 0
	jmp determinarPC

sltiu:	;Tipo I.
	mov r14, rax 													  ; Mueve instrucción a r14.
	printString slthaniu, lslthaniu 			  ; Imprime mnemonico.
	separarI r14
	printVal r12 													  ; Imprime rt.
	printString comma, lcomma
	printString dolar, ldolar
	printVal r13 													  ; Imprimer rs.
	printString comma, lcomma
	separarI r14
	printVal r11 												  	; Imprime inmediato.
	printString retorno, lretorno
	separarI r14 												    ; Asegurarse de que no se hayan perdido los datos de la instrucción.

	reg_mips r13
	mov rax, rdi													  ; Rax es rs en la alu.
	shl rax, 32
	shr rax, 32															; Cortar dato a 32 bits.
	sign_ext r11
	mov rcx, r11												   	; Rcx es rt en la alu.
	alu 4
	shl rbx, 32
	shr rbx, 32															; Asegurarse que el resultado sea de 32 bits.
	reg_mips r12
	mov [rsi], ebx												  ; Mueve resultado a registro mips rd.
	ImprimirRegistros												; Imprime contenido de los registros ao-a3, vo-v1, s0-s7
	mov ebx, 0
	jmp determinarPC

sll:	;Tipo R.
	printString shiftl, lshiftl 					  ; Imprime mnemonico.
	separarR r14
	printVal r11 													  ; Imprime rd.
	printString comma, lcomma
	printString dolar, ldolar
	printVal r12 													  ; Imprime rt.
	printString comma, lcomma
	printVal r10 													  ; Imprime shamt.
	printString retorno, lretorno
	separarR r14 													  ; Asegurarse de que no se hayan perdido los datos de la instrucción.

	mov r8, rcx														  ; En r8 dato a correr.
	mov rcx, r10													  ; En rcx shamt.
	shl r8, cl													  	; Corrimiento según el shamt.
	reg_mips r11
	mov [rsi], r8d													; Mueve resultado a rd.
	ImprimirRegistros												; Imprime contenido de los registros ao-a3, vo-v1, s0-s7
	mov ebx, 0
	jmp determinarPC

srl:	;Tipo R.
	printString shiftr, lshiftr						  ; Imprime mnemonico.
	separarR r14
	printVal r11 													  ; Imprime rd.
	printString comma, lcomma
	printString dolar, ldolar
	printVal r12 											  		; Imprime rt.
	printString comma, lcomma
	printVal r10 												  	; Imprime shamt.
	printString retorno, lretorno
	separarR r14 													  ; Asegurarse de que no se hayan perdido los datos de la instrucción.

	mov r8, rcx														  ; En r8 dato a correr.
	mov rcx, r10													  ; En rcx shamt.
	shr r8, cl														  ; Corrimiento según el shamt.
	reg_mips r11
	mov [rsi], r8d 												  ; Mueve resultado a rd.
	ImprimirRegistros												; Imprime contenido de los registros ao-a3, vo-v1, s0-s7
	mov ebx, 0
	jmp determinarPC

resta:	;Tipo R.
	printString restar, lrestar						  ; Imprime mnemonico.
	separarR r14
	printVal r11 													  ; Imprime rd.
	printString comma, lcomma
	printString dolar, ldolar
	printVal r13 													  ; Imprime rs.
	printString comma, lcomma
	printString dolar, ldolar
	printVal r12 													  ; Imprime rt.
	printString retorno, lretorno
	separarR r14 													  ; Asegurarse de que no se hayan perdido los datos de la instrucción.

	alu 3
	shl rbx, 32
	shr rbx, 32															; Asegurarse que el resultado sea de 32 bits.
	reg_mips r11
	mov [rsi], ebx 											  	; Mueve resultado a registro mips rd.
	ImprimirRegistros												; Imprime contenido de los registros ao-a3, vo-v1, s0-s7
	mov ebx, 0
	jmp determinarPC

restau:	;Tipo R.
	printString restaru, lrestaru					  ; Imprime mnemonico.
	separarR r14
	printVal r11 													  ; Imprime rd.
	printString comma, lcomma
	printString dolar, ldolar
	printVal r13 													  ; Imprime rs.
	printString comma, lcomma
	printString dolar, ldolar
	printVal r12 													  ; Imprime rt.
	printString retorno, lretorno
	separarR r14 													  ; Asegurarse de que no se hayan perdido los datos de la instrucción.

	alu 3
	shl rbx, 32
	shr rbx, 32															; Asegurarse que el resultado sea de 32 bits.
	reg_mips r11
	mov [rsi], ebx 												  ; Mueve resultado a registro mips rd.
	ImprimirRegistros												; Imprime contenido de los registros ao-a3, vo-v1, s0-s7
	mov ebx, 0
	jmp determinarPC

sw:	;Tipo I.
	mov r14, rax												    ; Mueve instrucción a r14.
	printString storew, lstorew 				    ; Imprime mnemonico.
	separarI r14
	printVal r12 												    ; Imprime rt.
	printString comma, lcomma
	separarI r14
	printVal r11 												    ; Imprime inmediato.
	printString parentizq, lparentizq
	printString dolar, ldolar
	printVal r13 												    ; Imprime rs.
	printString parentder, lparentder
	printString retorno, lretorno
	separarI r14 												    ; Asegurarse de que no se hayan perdido los datos de la instrucción.

	sign_ext r11												    ; Se toma el inmediato y se extiende el signo
	reg_mips r13												    ; Se utiliza la macro para obtener el valor y dirección de Rs
	mov r13, rdi
	shl r13, 32
	shr r13, 32															; Cortar dato a 32 bits.
	add r13, r11  											    ; Se suman ambos valores para calcular la dirección de memoria
	cmp r13, 99
	ja memoverflow											    ; Si se sobrepasa de las 100 palabras de memoria, imprime mensaje de error.
	mov rax, 4
	mul r13															    ; Se multiplica por 4 ya que la memoria se divide en bytes (palabras de 4*8bits)
	add rax, datos 											    ; Se suma a datos ya que es el valor inicial de memoria de datos en el computador real.
	reg_mips r12
	shl rdi, 32
	shr rdi, 32															; Cortar dato a 32 bits.
	mov [rax], rdi											    ; Se toma el valor de rt y se guarda en la dirección calculada en rax
	ImprimirRegistros												; Imprime contenido de los registros ao-a3, vo-v1, s0-s7
	cmp rsi, reg29
	je stackin
	reg_mips r13
	cmp rsi, reg29
	je stackin
	mov ebx, 0
	jmp determinarPC

stackin:		;PUSH
	mov r8,[reg29];
	mov [stack1+r8],r9d                     ; Push de pila
	mov r10, [stack1+r8]
	jmp vuelvestack


; ------------- Error de dirección inválida para jump register --------------
invaliddir:
	printString invdir, linvdir
	mov ebx, 0
	jmp determinarPC

invaliddirR:
	printString pointofnoreturn, lpointofnoreturn
	mov ebx, 0
	jmp determinarPC


; ------------- Error de dirección de memoria no encontrada ----------------
memoverflow:
	printString memmax, lmemmax
	exit

; ------------------- Error de instrucción no encontrada --------------------
instnotfound:
	printString nfound, lnfound
	mov ebx, 0
	jmp determinarPC

; ------------------------------ Fin del programa ---------------------------
gameover:
	printString retorno, lretorno
	printString exito, lexito										  ; Ejecución finalizada con éxito
	printString retorno, lretorno
	printString final, lfinal									  	; Imprime nombres de los miembros del grupo
	printString juan, ljuan
	printString joao, ljoao
	printString andre, landre
	printString steven, lsteven
	printString camila, lcamila
	printString retorno, lretorno
	printString cpuid2, lcpuid2									  ; Imprime datos del cpu
	printString tap, 1
	jmp datosMicro
	hastaaqui:
	printString retorno, lretorno
	printString theend, ltheend								  	; Imprime mensaje final "Presione enter para finalizar"
	jmp presionaEnter															; Se espera hasta que se presione enter para cerrar el programa
	exit

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

	;Esta sección permite obtener información del modelo y la familia
	mov eax,80000004h
	cpuid
	mov [datosCPU+32], eax
	mov [datosCPU+36], ebx
	mov [datosCPU+40], ecx
	mov [datosCPU+44], edx

	printString tap, 1
	printString datosCPU, 48
	printString retorno, lretorno
	jmp hastaaqui
; -------------- Lectura de Enter para continuar la ejecución --------------
	presionaEnterC:
			readString teclado,1
			mov r15, [teclado]
			cmp r15, 0xa
			jne presionaEnterC
			jmp holi

; ----------------- Lectura de Enter para salir la ejecución ---------------
presionaEnter:
		readString teclado,1
		mov r15, [teclado]
		cmp r15, 0xa
		jne presionaEnter
		exit
