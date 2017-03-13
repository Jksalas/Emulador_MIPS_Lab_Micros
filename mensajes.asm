;#################################################
;Impresión de mensajes de interración con usuario
;EL4313 - Laboratorio de Estructura de Microprocesadores
;#################################################

%include "linux64.inc"	

;--------------------Segmentos de datos----------------------

section .data

;NOTA: en caso de querer cambiar el color se modifica el #m. 

	uno: db  0x1b,"[38;5;183m","************************** Bienvenido al Emulador MIPS *************************", 0xa, 0xa
	uno_tamano: equ $-uno

	dos: db 0x1b,"[38;5;86m", "        EL-4313 - Lab Estructura de Microprocesadores", 0xa
	dos_tamano: equ $-dos
	
	tres: db 0x1b,"[38;5;86m", "        IS - 2017", 0xa
	tres_tamano: equ $-tres

	cuatro: db 0x1b,"[38;5;86m","        Buscando archivo ROM.txt", 0xa
	cuatro_tamano: equ $-cuatro

;------------------------- Segmento de codigo ---------------------

section .text
	global _start
	
_start:
	print uno ;Llamado al macro
	print dos
	print tres
	print cuatro 
	


