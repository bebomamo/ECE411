.section .text
.globl _start
_start: 
    la x4, test_data
    lw x1, 0(x4)
    addi x2, x1, 1
    slli x1, x1, 16
    sw x1, 4(x4)
    addi x1, x1, 1

    slti x0, x0, -256
    nop
    nop
    nop
    nop
    nop

.section .data 
test_data: 
    .word 0xDEADBEEF
    .word 0x12345678