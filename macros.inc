
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
	mensajeinicio:  db 0x1b, "[38;5;86m","        Presione enter para continuar", 0xa
	lmensajeinicio: equ $-mensajeinicio
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

	sumar: db 0x1b, "[38;5;41m","      	  Ejecutando add $"
	lsumar: equ $-sumar
	sumaru: db 0x1b, "[38;5;41m","      	  Ejecutando addu $"
	lsumaru: equ $-sumaru
	sumari: db 0x1b, "[38;5;41m","      	  Ejecutando addi $"
	lsumari: equ $-sumari
	sumariu: db 0x1b, "[38;5;41m","      	  Ejecutando addiu $"
	lsumariu: equ $-sumariu

	lalaland: db 0x1b, "[38;5;41m","      	  Ejecutando and $"
	lalalaland: equ $-lalaland
	lalalandi: db 0x1b, "[38;5;41m","      	  Ejecutando andi $"
	lalalalandi: equ $-lalalandi

	branchequal: db 0x1b, "[38;5;41m","      	  Ejecutando beq $"
	lbranchequal: equ $-branchequal
	branchnequal: db 0x1b, "[38;5;41m","      	  Ejecutando bne $"
	lbranchnequal: equ $-branchnequal

	jump: db 0x1b, "[38;5;41m","      	  Ejecutando j $"
	ljump: equ $-jump
	jumpal: db 0x1b, "[38;5;41m","      	  Ejecutando jal $"
	ljumpal: equ $-jumpal
	jumpreg: db 0x1b, "[38;5;41m","      	  Ejecutando jr $"
	ljumpreg: equ $-jumpreg

	storew: db 0x1b, "[38;5;41m","      	  Ejecutando sw $"
	lstorew: equ $-storew
	loadw: db 0x1b, "[38;5;41m","      	  Ejecutando lw $"
	lloadw: equ $-loadw

	multiplicar: db 0x1b, "[38;5;41m","      	  Ejecutando mult $"
	lmultiplicar: equ $-multiplicar

	nordico: db 0x1b, "[38;5;41m","      	  Ejecutando nor $"
	lnordico: equ $-nordico
	orcito: db 0x1b, "[38;5;41m","      	  Ejecutando or $"
	lorcito: equ $-orcito
	oricito: db 0x1b, "[38;5;41m","      	  Ejecutando ori $"
	loricito: equ $-oricito

	slthan: db 0x1b, "[38;5;41m","      	  Ejecutando slt $"
	lslthan: equ $-slthan
	slthani: db 0x1b, "[38;5;41m","      	  Ejecutando slti $"
	lslthani: equ $-slthani
	slthanu: db 0x1b, "[38;5;41m","      	  Ejecutando sltu $"
	lslthanu: equ $-slthanu
	slthaniu: db 0x1b, "[38;5;41m","      	  Ejecutando sltiu $"
	lslthaniu: equ $-slthaniu

	shiftl: db 0x1b, "[38;5;41m","      	  Ejecutando sll $"
	lshiftl: equ $-shiftl
	shiftr: db 0x1b, "[38;5;41m","      	  Ejecutando srl $"
	lshiftr: equ $-shiftr

	restar: db 0x1b, "[38;5;41m","      	  Ejecutando sub $"
	lrestar: equ $-restar
	restaru: db 0x1b, "[38;5;41m","      	  Ejecutando subu $"
	lrestaru: equ $-restaru

		; -------------------- LECTURA ROM.TXsT --------------------
		file db "./ROM.txt", 0
		len equ 2048
		n db 0

		; -------------------- Imprimir registros --------------------
		filename: db "myfile.txt",0

%macro ASCIIaENTERO 1
	and %1, 11111111b ; Guardar solo ultimos 8 bits
	cmp %1, 96
	ja %%elseL1
	sub %1, 48
	jmp %%end
	%%elseL1:
	sub %1, 87
	%%end:
%endmacro

%macro HexMemoria 3

	shl %1, 4
	add %1, %2
	mov [trama+%3], %1

%endmacro
%macro HexPC 3

	shl %1, 4
	add %1, %2
	mov [pc+%3], %1

%endmacro

%macro alu 1 ; 1 parámetro como "señal de ctrl".
	mov rdx, %1 ; "OP Code" de ALU. Se guarda en rdx.
%%and:
	cmp rdx, 0 ; 0 = AND.
	jne %%or ; Si no es, pasa a siguiente opción.
	and rax, rcx ; rax (rs) AND rcx (rt).
	jmp %%result ; Concluida la operación, pasa a resultado.
%%or:
	cmp rdx, 1 ; 1 = OR.
	jne %%add ; Si no es, pasa a siguiente opción.
	or rax, rcx ; rax (rs) OR rcx (rt).
	jmp %%result ; Concluida la operación, pasa a resultado.
%%add:
	cmp rdx, 2 ; 2 = ADD.
	jne %%substract ; Si no es, pasa a siguiente opción.
	add rax, rcx ; rax (rs) + rcx (rt).
	jmp %%result ; Concluida la operación, pasa a resultado.
%%substract:
	cmp rdx, 3; 3 = SUB.
	jne %%set_on_less_than ; Si no es, pasa a siguiente opción.
	sub rax, rcx ; rax (rs) - rcx (rt).
	jmp %%result ; Concluida la operación, pasa a resultado.
%%set_on_less_than:
	cmp rdx, 4; 4 = SLTU.
	jne %%nor ; Si no es, pasa a siguiente opción.
	cmp rcx, rax
	jg %%true  ; Si rcx (rt) > rax(rs).
	jmp %%false ; Si no.
	%%true:
		mov rbx, 1b ; Un 1 en rbx (rd).
		jmp %%end ; Se pasa a fin porque ya resultado está en rd.
	%%false:
		mov rbx, 0b ; Un 0 en rbx (rd).
		jmp %%end ; Se pasa a fin porque ya resultado está en rd.
%%nor:
	cmp rdx, 5; 5 = NOR.
	jne %%multiply ; Si no es, pasa a siguiente opción.
	or rax, rcx ; rax (rs) OR rcx (rt).
	not rax ; NOT rax (rs).
	jmp %%result ; Concluida la operación, pasa a resultado.
%%multiply:
	cmp rdx, 6 ; 6 = MULT.
	jne %%end ; Si no es, pasa a resultal sin hacer nada.
	mul rcx ; rax (rs) * rcx (rt).
	jmp %%result ; Concluida la operación, pasa a resultado.
%%result: ; Las operaciones realizadas ponen su resultado en rax.
	mov rbx, rax ; Mueve resultado de operación a rbx (rd).
%%end: ; Etiqueta para casos de no hacer nada.
%endmacro


; Esta macro toma un los registros en los que están las direcciones de los
; registros mips de la instrucción y le asigna a rsi la dirección correspondiente
; en memoria de la PC y a rdi el dato contenido en dicha dirección.

%macro reg_mips 1 ; 1 parámetro: registro donde está la dirección de rt, rs o rd.
	mov rdx, %1
	and rdx, 0x000000000000001f ; Aseguro que queden sólo los 5 bit de la dirección.
%%cero:
	cmp rdx, 0x0000000000000000
	jne %%uno
	mov rsi, reg0 ; Se guarda en rsi la dirección del registro mips.
	mov rdi, [reg0] ; Se guarda en rdi el dato del reg0 (en memoria).
	jmp %%listo
%%uno:
	cmp rdx, 0x0000000000000001
	jne %%dos
	mov rsi, reg1 ; Se guarda en rsi la dirección del registro mips.
	mov rdi, [reg1] ; Se guarda en rdi el dato del reg1 (en memoria).
	jmp %%listo
%%dos:
	cmp rdx, 0x0000000000000002
	jne %%tres
	mov rsi, reg2 ; Se guarda en rsi la dirección del registro mips.
	mov rdi, [reg2] ; Se guarda en rdi el dato del reg2 (en memoria).
	jmp %%listo
%%tres:
	cmp rdx, 0x0000000000000003
	jne %%cuatro
	mov rsi, reg3 ; Se guarda en rsi la dirección del registro mips.
	mov rdi, [reg3] ; Se guarda en rdi el dato del reg3 (en memoria).
	jmp %%listo
%%cuatro:
	cmp rdx, 0x0000000000000004
	jne %%cinco
	mov rsi, reg4 ; Se guarda en rsi la dirección del registro mips.
	mov rdi, [reg4] ; Se guarda en rdi el dato del reg4 (en memoria).
	jmp %%listo
%%cinco:
	cmp rdx, 0x0000000000000005
	jne %%seis
	mov rsi, reg5 ; Se guarda en rsi la dirección del registro mips.
	mov rdi, [reg5] ; Se guarda en rdi el dato del reg5 (en memoria).
	jmp %%listo
%%seis:
	cmp rdx, 0x0000000000000006
	jne %%siete
	mov rsi, reg6 ; Se guarda en rsi la dirección del registro mips.
	mov rdi, [reg6] ; Se guarda en rdi el dato del reg6 (en memoria).
	jmp %%listo
%%siete:
	cmp rdx, 0x0000000000000007
	jne %%ocho
	mov rsi, reg7 ; Se guarda en rsi la dirección del registro mips.
	mov rdi, [reg7] ; Se guarda en rdi el dato del reg7 (en memoria).
	jmp %%listo
%%ocho:
	cmp rdx, 0x0000000000000008
	jne %%nueve
	mov rsi, reg8 ; Se guarda en rsi la dirección del registro mips.
	mov rdi, [reg8] ; Se guarda en rdi el dato del reg8 (en memoria).
	jmp %%listo
%%nueve:
	cmp rdx, 0x0000000000000009
	jne %%diez
	mov rsi, reg9 ; Se guarda en rsi la dirección del registro mips.
	mov rdi, [reg9] ; Se guarda en rdi el dato del reg9 (en memoria).
	jmp %%listo
%%diez:
	cmp rdx, 0x000000000000000a
	jne %%once
	mov rsi, reg10 ; Se guarda en rsi la dirección del registro mips.
	mov rdi, [reg10] ; Se guarda en rdi el dato del reg10 (en memoria).
	jmp %%listo
%%once:
	cmp rdx, 0x000000000000000b
	jne %%doce
	mov rdi, [reg11] ; Se guarda en rdi el dato del reg11 (en memoria).
	mov rsi, reg11 ; Se guarda en rsi la dirección del registro mips.
	jmp %%listo
%%doce:
	cmp rdx, 0x000000000000000c
	jne %%trece
	mov rsi, reg12 ; Se guarda en rsi la dirección del registro mips.
	mov rdi, [reg12] ; Se guarda en rdi el dato del reg12 (en memoria).
	jmp %%listo
%%trece:
	cmp rdx, 0x000000000000000d
	jne %%catorce
	mov rsi, reg13 ; Se guarda en rsi la dirección del registro mips.
	mov rdi, [reg13] ; Se guarda en rdi el dato del reg13 (en memoria).
	jmp %%listo
%%catorce:
	cmp rdx, 0x000000000000000e
	jne %%quince
	mov rsi, reg14 ; Se guarda en rsi la dirección del registro mips.
	mov rdi, [reg14] ; Se guarda en rdi el dato del reg14 (en memoria).
	jmp %%listo
%%quince:
	cmp rdx, 0x000000000000000f
	jne %%dieciseis
	mov rsi, reg15 ; Se guarda en rsi la dirección del registro mips.
	mov rdi, [reg15] ; Se guarda en rdi el dato del reg15 (en memoria).
	jmp %%listo
%%dieciseis:
	cmp rdx, 0x0000000000000010
	jne %%diecisiete
	mov rsi, reg16 ; Se guarda en rsi la dirección del registro mips.
	mov rdi, [reg16] ; Se guarda en rdi el dato del reg16 (en memoria).
	jmp %%listo
%%diecisiete:
	cmp rdx, 0x0000000000000011
	jne %%dieciocho
	mov rsi, reg17 ; Se guarda en rsi la dirección del registro mips.
	mov rdi, [reg17] ; Se guarda en rdi el dato del reg17 (en memoria).
	jmp %%listo
%%dieciocho:
	cmp rdx, 0x0000000000000012
	jne %%diecinueve
	mov rsi, reg18 ; Se guarda en rsi la dirección del registro mips.
	mov rdi, [reg18] ; Se guarda en rdi el dato del reg18 (en memoria).
	jmp %%listo
%%diecinueve:
	cmp rdx, 0x0000000000000013
	jne %%veinte
	mov rsi, reg19 ; Se guarda en rsi la dirección del registro mips.
	mov rdi, [reg19] ; Se guarda en rdi el dato del reg19 (en memoria).
	jmp %%listo
%%veinte:
	cmp rdx, 0x0000000000000014
	jne %%ventiuno
	mov rsi, reg20 ; Se guarda en rsi la dirección del registro mips.
	mov rdi, [reg20] ; Se guarda en rdi el dato del reg20 (en memoria).
	jmp %%listo
%%ventiuno:
	cmp rdx, 0x0000000000000015
	jne %%ventidos
	mov rsi, reg21 ; Se guarda en rsi la dirección del registro mips.
	mov rdi, [reg21] ; Se guarda en rdi el dato del reg21 (en memoria).
	jmp %%listo
%%ventidos:
	cmp rdx, 0x0000000000000016
	jne %%ventitres
	mov rsi, reg22 ; Se guarda en rsi la dirección del registro mips.
	mov rdi, [reg22] ; Se guarda en rdi el dato del reg22 (en memoria).
	jmp %%listo
%%ventitres:
	cmp rdx, 0x0000000000000017
	jne %%venticuatro
	mov rsi, reg23 ; Se guarda en rsi la dirección del registro mips.
	mov rdi, [reg23] ; Se guarda en rdi el dato del reg23 (en memoria).
	jmp %%listo
%%venticuatro:
	cmp rdx, 0x0000000000000018
	jne %%venticinco
	mov rsi, reg24 ; Se guarda en rsi la dirección del registro mips.
	mov rdi, [reg24] ; Se guarda en rdi el dato del reg24 (en memoria).
	jmp %%listo
%%venticinco:
	cmp rdx, 0x0000000000000019
	jne %%ventiseis
	mov rsi, reg25 ; Se guarda en rsi la dirección del registro mips.
	mov rdi, [reg25] ; Se guarda en rdi el dato del reg25 (en memoria).
	jmp %%listo
%%ventiseis:
	cmp rdx, 0x000000000000001a
	jne %%ventisiete
	mov rsi, reg26 ; Se guarda en rsi la dirección del registro mips.
	mov rdi, [reg26] ; Se guarda en rdi el dato del reg26 (en memoria).
	jmp %%listo
%%ventisiete:
	cmp rdx, 0x000000000000001b
	jne %%ventiocho
	mov rdi, [reg27] ; Se guarda en rdi el dato del reg27 (en memoria).
	mov rsi, reg27 ; Se guarda en rsi la dirección del registro mips.
	jmp %%listo
%%ventiocho:
	cmp rdx, 0x000000000000001c
	jne %%ventinueve
	mov rsi, reg28 ; Se guarda en rsi la dirección del registro mips.
	mov rdi, [reg28] ; Se guarda en rdi el dato del reg28 (en memoria).
	jmp %%listo
%%ventinueve:
	cmp rdx, 0x000000000000001d
	jne %%treinta
	mov rsi, reg29 ; Se guarda en rsi la dirección del registro mips.
	mov rdi, [reg29] ; Se guarda en rdi el dato del reg29 (en memoria).
	jmp %%listo
%%treinta:
	cmp rdx, 0x000000000000001e
	jne %%treintayuno
	mov rsi, reg30 ; Se guarda en rsi la dirección del registro mips.
	mov rdi, [reg30] ; Se guarda en rdi el dato del reg30 (en memoria).
	jmp %%listo
%%treintayuno:
	cmp rdx, 0x000000000000001f
	jne %%listo
	mov rsi, reg31 ; Se guarda en rsi la dirección del registro mips.
	mov rdi, [reg31] ; Se guarda en rdi el dato del reg31 (en memoria).

%%listo:
and rdi, 0x0000000011111111
%endmacro


%macro sign_ext 1
; realiza la extensión de signo y la guarda en r11.
  mov rdx, %1
  mov rsi, %1
  shr rdx, 15 ; se corre para analizar bit 15.
  cmp rdx, 0x0000000000000001
  jne %%cerillo
  mov rbp, 0x00000000ffff0000 ; Si es 1 el bit 15.
  jmp %%see

%%cerillo:
  mov rbp, 0x0000000000000000 ; Si es 0 el bit 15.

%%see:
  or rbp, rsi ; Se agrega inmediato en la parte baja de rbp.
	mov r11, rbp
%endmacro


%macro branch_add 1
; calcula la branch address y la guarda en r11.
  mov rdx, %1
  mov rsi, %1
  shr rdx, 15 ; se corre para analizar bit 15.
  cmp rdx, 0x0000000000000001
  jne %%cerillo
  mov rbp, 0x00000000fffc0000 ; Si es 1 el bit 15.
  jmp %%see

%%cerillo:
  mov rbp, 0x0000000000000000 ; Si es 0 el bit 15.

%%see:
  shl rsi, 2
  or rbp, rsi ; Se agrega inmediato con dos 0's al final.
	mov r11, rbp
%endmacro


%macro separarR 1                   ;Recibe un parametro donde vendrá la instrucción
  mov r13, %1                       ;en r13 se tendrá el Rs
  mov r12, %1                       ;en r12 se tendrá el Rt
  mov r11, %1                       ;en r11 se tendrá el Rd
  mov r10, %1                       ;en r10 se tendrá el shamt
  mov r9, %1                        ;en r9 se tendrá el funct
  and r13, 0x0000000003e00000       ;Se filtra todo lo que no es Rs
  shr r13, 21                       ;y se coloca al inicio del registro
  and r12, 0x00000000001f0000       ;Se filtra todo lo que no es Rt
  shr r12, 16                       ;y se coloca al inicio del registro
  and r11, 0x000000000000f900       ;Se filtra todo lo que no es Rd
  shr r11, 11                       ;y se coloca al inicio del registro
  and r10, 0x00000000000007c0       ;Se filtra todo lo que no es shamt
  shr r10, 6                        ;y se coloca al inicio del registro
  and r9, 0x000000000000003f       ;Se filtra todo lo que no es funct
  reg_mips r13
  mov rax, rdi ; rax es rs en la alu.
  reg_mips r12
  mov rcx, rdi ; rcx es rt en la alu.
%endmacro


%macro separarI 1                   ;Recibe un parametro donde vendrá la instrucción
  mov r13, %1                       ;en r13 se tendrá el Rs
  mov r12, %1                       ;en r12 se tendrá el Rt
  mov r11, %1
  and r13, 0x0000000003e00000       ;Se filtra todo lo que no es Rs
  shr r13, 21                       ;y se coloca al inicio del registro
  and r12, 0x00000000001f0000       ;Se filtra todo lo que no es Rt
  shr r12, 16                       ;y se coloca al inicio del registro
  and r11, 0x000000000000ffff       ;Se filtra todo lo que no es immediate
%endmacro


%macro separarJ 1                   ;Recibe un parametro donde vendrá la instrucción
  mov r14, %1                       ;en r14 está el OP Code.
  and r14, 0xfc00000000000000
	shr r14, 26												;se corren para dejar solo el opcode
  mov r13, %1                       ;en r13 se tendrá address
  and r13, 0x0000000003ffffff
%endmacro
