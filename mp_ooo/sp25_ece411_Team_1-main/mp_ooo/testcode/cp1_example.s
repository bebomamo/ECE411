.section .text
.globl _start
_start:
    # Set up a base address in the data section
    la x4, test_data        # Load PC + (1 << 12) into x5 (4KB offset from current PC)
    nop
    nop
    nop
    nop
    nop
    
    # Basic register operations with edge cases
    lui x6, 0xFFFFF         # Load maximum upper immediate (shifted to x6)
    nop
    nop
    nop
    nop
    nop
    
    addi x7, x0, -2048      # Minimum 12-bit signed immediate (shifted to x7)
    nop
    nop
    nop
    nop
    nop
    
    add x8, x6, x7          # Add with potential overflow (shifted to x8)
    nop
    nop
    nop
    nop
    nop
    
    # Logical operations with edge cases
    xori x9, x8, 2047       # XOR with maximum 12-bit signed immediate (shifted to x9)
    nop
    nop
    nop
    nop
    nop
    
    ori x10, x9, -1         # OR with all ones (shifted to x10)
    nop
    nop
    nop
    nop
    nop
    
    andi x11, x10, 0x555    # AND with alternating bit pattern (shifted to x11)
    nop
    nop
    nop
    nop
    nop
    
    # Shift operations with various amounts
    slli x12, x11, 31       # Maximum left shift (shifted to x12)
    nop
    nop
    nop
    nop
    nop
    
    srli x13, x12, 16       # Medium right shift (shifted to x13)
    nop
    nop
    nop
    nop
    nop
    
    srai x14, x13, 1        # Arithmetic shift of potentially negative number (shifted to x14)
    nop
    nop
    nop
    nop
    nop
    
    # Load/store operations with different offsets (all 4-byte aligned)
    sw x14, 0(x4)           # Store to test_data+0 (aligned, shifted to x14)
    nop
    nop
    nop
    nop
    nop
    
    lh x15, 0(x4)           # Load halfword from test_data+0 (aligned, shifted to x15)
    nop
    nop
    nop
    nop
    nop
    
    lbu x16, 4(x4)          # Load byte unsigned from test_data+4 (aligned, shifted to x16)
    nop
    nop
    nop
    nop
    nop
    
    # More arithmetic with edge cases
    sub x17, x16, x15       # Subtract with potential underflow (shifted to x17)
    nop
    nop
    nop
    nop
    nop
    
    slt x18, x17, x6        # Set less than with large numbers (shifted to x18, compare with x6)
    nop
    nop
    nop
    nop
    nop
    
    sltiu x19, x18, -1      # Set less than unsigned with maximum value (shifted to x19)
    nop
    nop
    nop
    nop
    nop
    
    # End simulation
    slti x0, x0, -256       # Magic instruction to end simulation
    nop
    nop
    nop
    nop
    nop

.section .data
test_data:
    .word 0xDEADBEEF        # Test pattern 1 (4 bytes)
    .word 0x12345678        # Test pattern 2 (4 bytes)