.section .text
.globl _start
_start:
    #------------------------------------------------------------
    # Test U-type instructions: LUI and AUIPC
    #------------------------------------------------------------
    lui   x5, 0x12345         # Load upper immediate into x5
    auipc x6, 0x0             # AUIPC adds current PC to immediate

    lui x10, 419430
    #------------------------------------------------------------
    # ALU operations and data hazards (testing forwarding)
    #------------------------------------------------------------
    addi  x1, x0, 10          # x1 = 10
    addi  x2, x0, 20          # x2 = 20
    add   x3, x1, x2          # x3 = 10 + 20, using x1 and x2 immediately
    sub   x4, x3, x1          # x4 = x3 - x1, data hazard from x3 and x1
    sll   x7, x1, 2           # Shift left: x7 = x1 << 2
    srl   x8, x7, 1           # Shift right logical: x8 = x7 >> 1
    sra   x3, x8, 2           # Shift right arithmetic: x9 = x8 >> 2
    and   x10, x3, x2         # Bitwise AND
    or    x11, x3, x2         # Bitwise OR
    xor   x12, x3, x2         # Bitwise XOR
    slt   x13, x1, x2         # Set x13 = 1 if x1 < x2 else 0
    sltu  x14, x2, x1         # Set unsigned: x14 = 1 if x2 < x1 else 0

    # data hazards with load after, arithmetic, and wb forwarding 
    la    x20, data_section   # Load address of data_section into x20
    addi x1, x0, 10
    addi x1, x1, 10
    addi x1, x1, 10
    addi x1, x1, 10
    lw x1, 0(x20)
    add x1, x1, x1
    addi x1, x1, -10 
    lw x1, 4(x20)
    lw x1, 0(x20) #<-
    lh x1, 0(x20)
    addi x1, x1, 10
    sw  x1, 0(x20)
    lw x1, 0(x20)

    #------------------------------------------------------------
    # Load-use hazard: lw immediately followed by an arithmetic op.
    #------------------------------------------------------------
    la    x20, data_section   # Load address of data_section into x20
    lw    x15, 0(x20)         # Load word from data_section into x15
    addi  x16, x15, 5         # Use loaded value immediately (hazard test)

    #------------------------------------------------------------
    # Memory operations that might create structural hazards
    # (Two memory accesses in back-to-back cycles.)
    #------------------------------------------------------------
    lw    x17, 4(x20)            # Load word from data_section + 4
    sw    x17, 0(x20)            # Store the loaded word back into data_section

    #------------------------------------------------------------
    # Branch tests: testing pipeline flush and hazard resolution.
    # 1. A branch that is taken.
    # 2. A branch that is not taken.
    #------------------------------------------------------------
    addi  x18, x0, 0             # x18 = 0
    beq   x18, x0, branch_taken  # Branch always taken (0==0)
    addi  x19, x0, 100           # This instruction should be flushed if branch is taken

branch_taken:
    addi  x20, x0, 200           # Branch destination target

    # Now test a branch that is NOT taken.
    addi  x21, x0, 1           # x21 = 1
    addi  x22, x0, 1           # x22 = 1
    bne   x21, x22, branch_not_taken  # Not taken since 1==1
    addi  x23, x0, 300         # This instruction executes sequentially
branch_not_taken:
    addi  x24, x0, 400         # Label destination

    #------------------------------------------------------------
    # Jump instructions to test pipeline flush on jumps.
    #------------------------------------------------------------
    jal   x1, jump_target      # Jump and Link: jump to jump_target and save return address in x1
    addi x1, x0, 0             # Should be skiped
jump_target:
    la    x1, func
    #lw    x1, 0(x1)
    auipc x3, 0
    addi x3, x3, 8
    la x3, data_section
    lw x3, 0(x3)
    jalr  x2, 0(x1)            # Jump and Link Register: jump to address in x1, store return in x2

    #------------------------------------------------------------
    # Additional forwarding hazard tests:
    # Create a chain of arithmetic instructions that depend on each other.
    #------------------------------------------------------------
label:
    addi  x26, x0, 1000        # Immediate load into x26
    add   x27, x26, x25        # x27 = x26 + x25 (x25 might have been set earlier by jump target)
    sub   x28, x27, x26        # x28 = x27 - x26, immediate dependency on x27
    and   x29, x28, x27        # x29 = x28 AND x27
    or    x30, x29, x28        # x30 = x29 OR x28
    xor   x31, x30, x29        # x31 = x30 XOR x29
    jal x1, end

func:
    beq x3, x2, label
end:
    #------------------------------------------------------------
    # Structural hazard test: back-to-back memory store and load to the same address.
    #------------------------------------------------------------
    la    x20, data_section
    sw    x31, 0(x20)            # Store result in data_section
    lw    x1, 0(x20)             # Immediately load from same address

    #------------------------------------------------------------
    # Ending the simulation
    #------------------------------------------------------------
    slti x0, x0, -256     # Magic instruction to stop simulation
    nop
    nop
    nop
    nop
    nop

.section .data
data_section:
    .word 0x11223344
    .word 0x55667788

