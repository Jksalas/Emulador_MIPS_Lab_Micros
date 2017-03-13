;#################################################
;Impresión de mensajes de interración con usuario
;EL4313 - Laboratorio de Estructura de Microprocesadores
;#################################################

%include "linux64.inc"

;--------------------Segmentos de datos----------------------

section .data

;NOTA: en caso de querer cambiar el color se modifica el #m.

	bienvenido: db  0x1b,"[38;5;183m","************************** Bienvenido al Emulador MIPS *************************", 0xa, 0xa
	lab: db 0x1b,"[38;5;86m", "        EL-4313 - Lab Estructura de Microprocesadores", 0xa
	sem: db 0x1b,"[38;5;86m", "        IS - 2017", 0xa
	buscando: db 0x1b,"[38;5;86m","        Buscando archivo ROM.txt", 0xa
	encuentra: db 0x1b,"[38;5;86m","        Archivo ROM.txt encontrado", 0xa
	noencuentra: db 0x1b, "[38;5;86m","        Archivo ROM.txt no encontrado", 0xa
	inicio:  db 0x1b, "[38;5;86m","        Presione enter para continuar", 0xa
	exito: db 0x1b, "[38;5;86m","        Ejecución exitosa", 0xa
	fallo: db 0x1b, "[38;5;86m","        Ejecución fallida", 0xa
	final: db 0x1b, "[38;5;86m","        Realizado por:", 0xa
	juan: db 0x1b, "[38;5;86m","      	  Juan José Vásquez ", 0xa
	joao: db 0x1b, "[38;5;86m","     	  Joao Kmil Salas Ramirez 2014096609", 0xa
	steven: db 0x1b, "[38;5;86m","      	  Steven León Domínguez 2014138025", 0xa
	andre: db 0x1b, "[38;5;86m","     	  André Martínez Arana 2014068625", 0xa
	camila: db 0x1b, "[38;5;86m","     	  Camila Gómez Molina 2014089559", 0xa




;------------------------- Segmento de codigo ---------------------

section .text
	global _start

_start:
	print bienvenido ;Llamado al macro
	print lab
	print sem
	print buscando
	print encuentra
	print noencuentra
	print inicio
	print exito
	print fallo
	print final
	print juan
	print joao
	print steven
	print andre
	print camila
	exit
