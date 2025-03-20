.section .text
.globl _start
_start:
    auipc x6, 0x1
    nop
    nop
    nop
    nop
    nop
    addi x6, x6, 4
    nop
    nop
    nop
    nop
    nop
    lw x24, -4(x6)
    nop
    nop
    nop
    nop
    nop
    addi x1, x0, 4
    nop             # nops in between to prevent hazard
    nop
    nop
    nop
    nop
    andi x20, x0, 0
    nop
    nop
    nop
    nop
    nop
    addi x20, x0, 186
    nop
    nop
    nop
    nop
    nop
    slli x20, x20, 8
    nop
    nop
    nop
    nop
    nop
    addi x20, x20, 190
    nop
    nop
    nop
    nop
    nop
    slli x20, x20, 8
    nop
    nop
    nop
    nop
    nop
    addi x20, x20, 202
    nop
    nop
    nop
    nop
    nop
    slli x20, x20, 8
    nop
    nop
    nop
    nop
    nop
    addi x20, x20, 254
    nop
    nop
    nop
    nop
    nop

    andi x5, x0, 0
    nop
    nop
    nop
    nop
    nop
    addi x5, x0, 170
    nop
    nop
    nop
    nop
    nop
    slli x5, x5, 8
    nop
    nop
    nop
    nop
    nop
    addi x5, x5, 170
    nop
    nop
    nop
    nop
    nop
    slli x5, x5, 8
    nop
    nop
    nop
    nop
    nop
    addi x5, x5, 176
    nop
    nop
    nop
    nop
    nop
    slli x5, x5, 8
    nop
    nop
    nop
    nop
    nop

    addi x6, x5, 4
    nop
    nop
    nop
    nop
    nop
    sw x20, 0(x5)
    nop
    nop
    nop
    nop
    nop

    lw x24, -4(x6)
    nop
    nop
    nop
    nop
    nop

    slti x0, x0, -256 # this is the magic instruction to end the simulation
    nop               # preventing fetching illegal instructions
    nop
    nop
    nop
    nop

.section .data
some_data_1:
    .word 0xbabecafe
