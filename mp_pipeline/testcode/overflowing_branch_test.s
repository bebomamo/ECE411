.section .text
.globl _start
_start: 
    lw x10, bebo
    lw x11 ,bebo_
    bge x10, x11, place
    lw x10, bebo__
    lw x11, bebo___
    blt x10, x11, place



place:
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
    .word 0xffdfffff
bebo_:
    .word 0x7fffffff
bebo__:
    .word 0x55555555
bebo___:
    .word 0xaaaaaaaa
