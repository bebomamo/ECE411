.section .text
.globl _start
_start:
    addi x1, x0, 4
    nop             # nops in between to prevent hazard
    nop
    nop
    nop
    nop
    addi x3, x1, 8
    nop
    nop
    nop
    nop
    nop
    lui x4, 20
    nop
    nop
    nop
    nop
    nop
    auipc x5, 20
    nop
    nop
    nop
    nop
    nop
    sub x5, x4, x3
    nop
    nop
    nop
    nop
    nop
    addi x3, x3, -2048
    nop
    nop
    nop
    nop
    nop
    addi x21, x3, 1
    nop
    nop
    nop
    nop
    nop
    addi x22, x3, 2
    nop
    nop
    nop
    nop
    nop
    addi x23, x3, 3
    nop
    nop
    nop
    nop
    nop
    addi x24, x3, 4
    nop
    nop
    nop
    nop
    nop
    sw x5, 0(x3)
    nop
    nop
    nop
    nop
    nop
    lw x4, 0(x3)
    nop
    nop
    nop
    nop
    nop
    lb x4, 0(x3)
    nop
    nop
    nop
    nop
    nop
    lb x4, 0(x21)
    nop
    nop
    nop
    nop
    nop
    lb x4, 0(x22)
    nop
    nop
    nop
    nop
    nop
    lb x4, 0(x23)
    nop
    nop
    nop
    nop
    nop
    lbu x4, 0(x3)
    nop
    nop
    nop
    nop
    nop
    lbu x4, 0(x21)
    nop
    nop
    nop
    nop
    nop
    lbu x4, 0(x22)
    nop
    nop
    nop
    nop
    nop
    lbu x4, 0(x23)
    nop
    nop
    nop
    nop
    nop
    lh x4, 0(x3)
    nop
    nop
    nop
    nop
    nop
    lh x4, 0(x22)
    nop
    nop
    nop
    nop
    nop
    addi x30, x0, 238
    nop
    nop
    nop
    nop
    nop
    sb x30, 0(x3)
    nop
    nop
    nop
    nop
    nop
    sb x30, 0(x21)
    nop
    nop
    nop
    nop
    nop
    sb x30, 0(x22)
    nop
    nop
    nop
    nop
    nop
    sb x30, 0(x23)
    nop
    nop
    nop
    nop
    nop
    lhu x4, 0(x3)
    nop
    nop
    nop
    nop
    nop
    lhu x4, 0(x22)
    nop
    nop
    nop
    nop
    nop
    addi x30, x0, 255
    nop
    nop
    nop
    nop
    nop
    sh x30, 0(x3)
    nop
    nop
    nop
    nop
    nop
    sh x30, 0(x22)
    nop
    nop
    nop
    nop
    nop
    lw x4, -4(x24)
    nop
    nop
    nop
    nop
    nop
    lhu x4, 0(x3)
    nop
    nop
    nop
    nop
    nop
    lhu x4, 0(x22)
    nop
    nop
    nop
    nop
    nop
    xori x5, x2, 100
    nop
    nop
    nop
    nop
    nop
    ori x4, x3, 250
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
    .word 0xAA552333
