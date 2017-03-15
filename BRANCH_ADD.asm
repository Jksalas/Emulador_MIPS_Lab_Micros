%macro branch_add 1
; calcula la branch address y la guarda en rbp.
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
%endmacro

section .text


  global _start
  global _uno
  global _dos

_start:
  mov r15, 0x000000000000ffff
  branch_add r15

_uno:
  mov r13, 0x0000000000007fff
  branch_add r13
_dos:
  mov rax, 60	; Se carga la llamada 60d (sys_exit) en rax.
	mov rdi, 0	; En rdi se carga un 0.
	syscall
