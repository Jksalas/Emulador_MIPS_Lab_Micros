

section .text
  global _start

_start:


;----------------------------Decodificación----------------------------
.decode:
  mov r13, r14                        ;Se copia la instrucción a otro registro
  sar r13, 26                         ;y se mueve a la derecha para dejar solo el código de operación

  cmp r13, 100000b                    ;compara con op code, en este caso de add
  je .suma                            ;salta a la etiqueta correspondiente, en este caso .suma
  cmp r13, 100001b                    ;compara con addu
  je .sumau                           ;salta a .sumau
  cmp r13, 001000b                    ;compara con addi
  je .sumai                           ;salta a .sumai
  cmp r13, 001001b                    ;compara con addiu
  je .sumaiu                          ;salta a .sumaiu
  cmp r13, 100100b                   ;compara con and
  je .y                               ;salta a .y
  cmp r13, 001100b                    ;compara con andi
  je .yi                              ;salta a .y
  cmp r13, 000100b                   ;compara con beq
  je .beq                             ;salta a .beq
  cmp r13, 000101b                    ;compara con bne
  je .bne                             ;salta a .bne
  cmp r13, 000010b                    ;compara con j
  je .j                               ;salta a .j
  cmp r13, 000011b                    ;compara con jal
  je .jandl                           ;salta a .jandl
  cmp r13, 001000b                    ;compara con jr
  je .jr                              ;salta a .jr
  cmp r13, 100011b                    ;compara con lw
  je .lw                              ;salta a .lw
  cmp r13, 011000b                    ;compara con mult
  je .mult                            ;salta a .mult
  cmp r13, 100111b                    ;compara con nor
  je .nor                             ;salta a .nor
  cmp r13, 100101b                    ;compara con or
  je .o                               ;salta a .o
  cmp r13, 001101b                    ;compara con ori
  je .ori                             ;salta a .ori
  cmp r13, 101010b                    ;compara con slt
  je .slt                             ;salta a .slt
  cmp r13, 001010b                    ;compara con slti
  je .slti                            ;salta a .slti
  cmp r13, 001001b                    ;compara con sltiu
  je .sltiu                           ;salta a .sltiu
  cmp r13, 101001b                    ;compara con sltu
  je .sltu                            ;salta a .sltu
  cmp r13, 000000b                    ;compara con sll
  je .sll                             ;salta a .sll
  cmp r13, 000010b                    ;compara con srl
  je .srl                             ;salta a .srl
  cmp r13, 100010b                    ;compara con sub
  je .resta                           ;salta a .resta
  cmp r13, 100011b                    ;compara con subu
  je .restau                          ;salta a .restau
  cmp r13, 101011b                    ;compara con sw
  je .sw                              ;salta a .sw

  jmp .instnotfound                   ;si la instrucción no se
                                      ;encuentra en el set que
                                      ;maneja el procesador
                                      ;se ejecuta una rutina que
                                      ;lo informa en pantalla

;--------------------Error de instruccíon no encontrada-----------------
.instnotfound:

;------------------rutinas correspondientes a cada inst-----------------

.suma:

.sumau:

.sumai:

.sumaiu:

.y:

.yi:

.beq:

.bne:

.j:

.jandl:

.jr:

.lw:

.mult:

.nor:

.o:

.ori:

.slt:

.slti:

.sltiu:

.sltu:

.sll:

.srl:

.resta:

.restau:

.sw:
