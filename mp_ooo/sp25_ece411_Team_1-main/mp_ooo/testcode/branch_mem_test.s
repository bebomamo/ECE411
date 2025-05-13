branch_mem_test.s:
.align 4
.section .text
.globl _start
    # This program consists of small snippets
    # containing branch, jump and mem instruction

    # This test is NOT exhaustive
_start:

# initialize regs to test with
li x1,  1
li x2,  2
li x3,  3
li x4,  4
li x5,  5
li x6,  6
li x7,  7
li x8,  8

la x3, test_data
lw x4, (x3)
sw x20, (x3)

blt x1, x7, bne_test           # Taking
nop
nop
nop
nop
nop

bne_test:
bne x1, x2, bne_taken      # taken   
add x4, x2, x3
nop
bne_taken:
bne x1, x1, bne_test   #not taken
nop

beq x1, x1, L1
addi x10, x0, 100
L1:

jal x15, L4 

beq x1, x2, L2
addi x11, x0, 101
L2:

jalr x16, 8(x2)

bne x1, x2, L3
addi x12, x0, 102
L3:

bne x1, x1, L4
addi x13, x0, 103
L4:

blt x1, x2, L5
addi x14, x0, 104
L5:

blt x2, x1, L6
addi x15, x0, 105
L6:

bge x2, x1, L7
addi x16, x0, 106
L7:

bge x1, x2, L8
addi x17, x0, 107
L8:

bltu x6, x5, L9
addi x18, x0, 108
L9:

bltu x5, x6, L10
addi x19, x0, 109
L10:

bgeu x5, x6, L11
addi x20, x0, 110
L11:

bgeu x6, x5, L12
addi x21, x0, 111
L12:

blt x1, x7, halt
add x5, x4, x4
add x5, x4, x4

halt:
    slti x0, x0, -256

test_data:
    .word 0xCAFEBEEF