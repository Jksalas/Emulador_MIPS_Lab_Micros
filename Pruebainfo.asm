%include "linux64.inc"
%include "macros.inc"
;----------------------------------------------------
;             Sección de Datos
;----------------------------------------------------

section .data
  linea_uno: db 'Hola Babys First line', 0xa
  l1_tamano: equ $-linea_uno

  linea_dos: db 'Hola Babys Second line', 0xa
  l2_tamano: equ $-linea_dos

;----------------------------------------------------
;             Sección de Código
;----------------------------------------------------
section.text
  global _start

_start:
	jmp datosMicro

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
  syscall

  mov rax,60
  mov rdi,0
  syscall
