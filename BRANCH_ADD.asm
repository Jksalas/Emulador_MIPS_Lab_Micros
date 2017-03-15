%macro branch_add 1
; calcula la branch address y la guarda en rbp.
  mov rdx, %1
  mov rsi, %1
  shr rdx, 14 ; se corre para analizar bit 15.
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
