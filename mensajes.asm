;#################################################
;Impresión de mensajes de interración con usuario
;EL4313 - Laboratorio de Estructura de Microprocesadores
;#################################################

%include "linux64.inc"	

;--------------------Segmentos de datos----------------------

section .data

;NOTA: en caso de querer cambiar el color se modifica el #m. 

	bienvenido: db  0x1b,"[38;5;183m","************************** Bienvenido al Emulador MIPS *************************", 0xa, 0xa
	bienvenido_tamano: equ $-bienvenido

	lab: db 0x1b,"[38;5;86m", "        EL-4313 - Lab Estructura de Microprocesadores", 0xa
	lab_tamano: equ $-lab
	
	sem: db 0x1b,"[38;5;86m", "        IS - 2017", 0xa
	sem_tamano: equ $-sem

	buscando: db 0x1b,"[38;5;86m","        Buscando archivo ROM.txt", 0xa
	buscando_tamano: equ $-buscando

;------------------------- Segmento de codigo ---------------------

section .text
	global _start
	
_start:
	print bienvenido ;Llamado al macro
	print lab
	print sem
	print buscando
