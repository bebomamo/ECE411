.section .text
.globl _start
_start: 
    li x4, 5
    li x5, 5
    beq x4, x5, equal

    j place

equal:
    li x4, 5
    li x5, 3
    bne x4, x5, not_equal

    j place

not_equal:
    li x4, 5
    li x5, 10
    blt x4, x5, less_than

    j place

less_than:
    li x4, 10
    li x5, 5
    bge x4, x5, greater_equal

    j place

greater_equal:
    j place
    add x8, x0, x0


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
    .word 0x0000beb0