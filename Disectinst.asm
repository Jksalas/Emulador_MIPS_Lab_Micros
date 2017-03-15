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

;section .text
;  global _start
;
;_start:
;  mov rax, 0x0c100009
;  separarJ rax
