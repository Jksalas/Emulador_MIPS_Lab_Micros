; esta macro toma un los registros en los que están las direcciones de los
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
%endmacro
