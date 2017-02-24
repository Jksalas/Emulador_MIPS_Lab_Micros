

section .text
  global _start

_start:

.decode:
  mov r13, r14                        ;Se copia la instrucción a otro registro
  sar r13, 26                         ;y se mueve a la derecha para dejar solo el código de operación

  cmp r13, b100000                    ;compara con op code, en este caso de add
  je .suma                            ;salta a la etiqueta correspondiente, en este caso .suma
  cmp r13, b100001                    ;compara con addu
  je .sumau                           ;salta a .sumau
  cmp r13, b001000                    ;compara con addi
  je .sumai                           ;salta a .sumai
  cmp r13, b001001                    ;compara con addiu
  je .sumaiu                          ;salta a .sumaiu
  cmp r13, b100100                    ;compara con and
  je .y                               ;salta a .y
  cmp r13, b001100                    ;compara con andi
  je .yi                              ;salta a .y
  cmp r13, b000100                    ;compara con beq
  je .beq                             ;salta a .beq
  cmp r13, b000101                    ;compara con bne
  je .bne                             ;salta a .bne
  cmp r13, b000010                    ;compara con j
  je .j                               ;salta a .j
  cmp r13, b000011                    ;compara con jal
  je .jandl                           ;salta a .jandl
  cmp r13, b001000                    ;compara con jr
  je .jr                              ;salta a .jr
  cmp r13, b100011                    ;compara con lw
  je .lw                              ;salta a .lw
  cmp r13, b011000                    ;compara con mult
  je .mult                            ;salta a .mult
  cmp r13, b100111                    ;compara con nor
  je .nor                             ;salta a .nor
  cmp r13, b100101                    ;compara con or
  je .o                               ;salta a .o
  cmp r13, b001101                    ;compara con ori
  je .ori                             ;salta a .ori
  cmp r13, b101010                    ;compara con slt
  je .slt                             ;salta a .slt
  cmp r13, b001010                    ;compara con slti
  je .slti                            ;salta a .slti
  cmp r13, b001001                    ;compara con sltiu
  je .sltiu                           ;salta a .sltiu
  cmp r13, b101001                    ;compara con sltu
  je .sltu                            ;salta a .sltu
  cmp r13, b000000                    ;compara con sll
  je .sll                             ;salta a .sll
  cmp r13, b000010                    ;compara con srl
  je .srl                             ;salta a .srl
  cmp r13, b100010                    ;compara con sub
  je .resta                           ;salta a .resta
  cmp r13, b100011                    ;compara con subu
  je .restau                          ;salta a .restau
  cmp r13, b101011                    ;compara con sw
  je .sw                              ;salta a .sw

  jmp .instnotfound                   ;si la instrucción no se
                                      ;encuentra en el set que
                                      ;maneja el procesador
                                      ;se ejecuta una rutina que
                                      ;lo informa en pantalla
