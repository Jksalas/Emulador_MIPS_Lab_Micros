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
  and r12, 0x000000000000f900       ;Se filtra todo lo que no es Rd
  shr r12, 11                       ;y se coloca al inicio del registro
  and r12, 0x00000000000007c0       ;Se filtra todo lo que no es shamt
  shr r12, 6                        ;y se coloca al inicio del registro
  and r12, 0x000000000000003f       ;Se filtra todo lo que no es funct
%endmacro

%macro separarI 1                   ;Recibe un parametro donde vendrá la instrucción
  mov r13, %1                       ;en r13 se tendrá el Rs
  mov r12, %1                       ;en r12 se tendrá el Rt
  mov r11, %1
  and r13, 0x0000000003e00000       ;Se filtra todo lo que no es Rs
  shr r13, 21                       ;y se coloca al inicio del registro
  and r12, 0x00000000001f0000       ;Se filtra todo lo que no es Rt
  shr r12, 16                       ;y se coloca al inicio del registro
  and r12, 0x000000000000ffff       ;Se filtra todo lo que no es immediate
%endmacro

%macro separarJ 1                   ;Recibe un parametro donde vendrá la instrucción
  mov r13, %1                       ;en r13 se tendrá address
  and r13, 0x0000000003ffffff
%endmacro
