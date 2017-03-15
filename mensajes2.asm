;#################################################
;Impresión de mensajes de interración con usuario
;EL4313 - Laboratorio de Estructura de Microprocesadores
;#################################################

%include "linux64.inc"

;--------------------Segmentos de datos----------------------

section .data

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



;------------------------- Segmento de codigo ---------------------

section .text
	global _start

_start:
	printString bienvenido, lbienvenido ;Llamado al macro
	printString lab, llab
	printString sem, lsem
	printString buscando, lbuscando
	printString encuentra, lencuentra
	printString noencuentra, lnoencuentra
	printString inicio, linicio
	printString exito, lexito
	printString fallo, lfallo
	printString final, lfinal
	printString juan, ljuan
	printString joao, ljoao
	printString steven, lsteven
	printString andre, landre
	printString camila, lcamila
	exit
