.section .text
.globl _start
_start: 
    la x4, test_data
    lw x1, 0(x4)
    addi x2, x1, 1
    la x5, place
    sw x5, 0(x4)
    lw x18, 0(x4)
    jalr x0, 0(x18)
    slli x1, x1, 16
    sw x1, 4(x4)
    addi x1, x1, 1


place:
    lw x20, bebo

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
bebo:
    .word 0x0000beb0