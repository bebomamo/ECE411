package rv32i_types;

    // Adjust Parameters for Performance Tuning
    localparam integer NUM_PHYS_REGS = 32;
    localparam integer PHYS_REG_ADDR_WIDTH = $clog2(NUM_PHYS_REGS);
    localparam integer NUM_ROB_ENTRIES = 32;
    localparam integer ROB_ADDR_WIDTH = $clog2(NUM_ROB_ENTRIES);

    localparam integer SQ_DEPTH = 8;
    localparam integer SQ_ADDR_WIDTH = $clog2(SQ_DEPTH);
    localparam integer RS_ARITH_DEPTH = 16;
    localparam integer RS_MEM_DEPTH = 32;
    localparam integer RS_BR_DEPTH = 8;
    localparam integer RS_MUL_DEPTH = 8;

    
    // General Enums
    typedef enum logic {
        INVALID = 1'b0,
        VALID = 1'b1
    } valid_t;

    typedef enum logic {
        DEFAULT = 1'b0,
        FREE_LIST = 1'b1
    } fifo_custom_t;

    typedef enum logic {
        NOT_TAKEN = 1'b0,
        TAKEN = 1'b1
    } taken_t;

    typedef enum logic [1:0] {
        ARITH_UNIT      = 2'b00,
        MEM_UNIT        = 2'b01,
        BR_UNIT         = 2'b10,
        MUL_DIV_UNIT    = 2'b11
    } funct_unit_t;

    // RAT + ARF
    typedef struct packed {
        logic           valid;
        logic           renamed;
        logic   [PHYS_REG_ADDR_WIDTH-1:0] paddr;
        logic   [31:0]  data;
    } rat_arf_t;

    // PRs
    typedef struct packed {
        logic           valid;
        logic   [31:0]  data;
    } prf_t;

    // Common Data Bus
    typedef struct packed {
        valid_t                             valid;
        logic   [PHYS_REG_ADDR_WIDTH-1:0]   rd_paddr;
        logic   [31:0]                      rd_data;
        logic                               rd_valid;
        logic   [ROB_ADDR_WIDTH-1:0]        rob_addr;
        logic                               br_result;

        logic [31:0]                        rs1_data;
        logic [31:0]                        rs2_data;
    } cdb_t;

    // FETCH Stage
    typedef struct packed {
        logic   [31:0]  instr;
        logic   [31:0]  pc_rdata;
        logic   [31:0]  pc_wdata;
    } fetch_pkt_t;

    // For RVFI, may need masks
    typedef struct packed {
        logic   [31:0]  instr;
        logic   [31:0]  pc_rdata;
        logic   [31:0]  pc_wdata;
        valid_t         rs1_valid;
        valid_t         rs2_valid;
        valid_t         rd_valid;
    } instr_info_t;

    // would be part of instr_info_t
    typedef struct packed {
        logic   [31:0]  rs1_data;
        logic   [31:0]  rs2_data;
    } rs_data_info_t;

    // DECODE -> Dispatch
    typedef struct packed {
        // Instruction Meta Signals
        logic   [31:0]  instr;
        logic   [31:0]  pc_rdata;
        logic   [31:0]  pc_wdata;
        logic   [4:0]   rs1_addr;
        logic   [4:0]   rs2_addr;
        logic   [4:0]   rd_addr;
        logic   [PHYS_REG_ADDR_WIDTH-1:0]   rd_paddr;
        valid_t         rs1_valid;
        valid_t         rs2_valid;
        valid_t         rd_valid;
        valid_t         valid;
        // Decode singals
        logic   [6:0]   opcode;
        logic   [1:0]   funct_unit;
        logic   [2:0]   funct3;
        logic   [3:0]   alu_op;
        logic   [3:0]   r_mask;
        logic   [3:0]   w_mask;
        // Dispatch Signals
        logic           rs1_ready;
        logic           rs2_ready;
        logic [31:0]    rs1_data;   // Does not have to be from rs1 if rs1_valid = 0
        logic [31:0]    rs2_data;
        // branch prediction
        taken_t         br_pred;
    } instr_t;

    // ROB
    typedef enum logic {
        WAIT = 1'b0,
        DONE = 1'b1
    } rob_status_t;

    typedef struct packed {
        valid_t                     valid;
        rob_status_t                status;
        logic [1:0]                 op;
        instr_info_t                 instr_info;
        logic [PHYS_REG_ADDR_WIDTH-1:0]  rd_paddr;
        rs_data_info_t rs_info;

        logic [4:0]                 rd_addr;
        taken_t                     br_pred;
        taken_t                     br_result;
    } rob_t;

    // Reservation Station
    typedef struct packed {
        // instr_t         inst_pkt;
        valid_t         valid;
        logic [ROB_ADDR_WIDTH-1:0]      rob_addr;
        logic           rs1_ready;
        logic           rs2_ready;
        logic [31:0]    rs1_data;   // Does not have to be from rs1 if rs1_valid = 0
        logic [31:0]    rs2_data;
        logic [PHYS_REG_ADDR_WIDTH-1:0] rd_paddr;
        // Functional Unit Operation // TODO break apart in future
        logic [31:0]    pc_wdata;
        logic           rd_valid;
        logic [3:0]     alu_op;
        logic [2:0]     mul_div_op;
        logic [2:0]     mem_op;
        logic [2:0]     branch_op;
        logic [31:0]    store_imm; 
        logic [3:0]     w_mask;
        logic [3:0]     r_mask;
    } rs_t;

    typedef struct packed {
        logic [31:0] address;
        logic [3:0]  r_mask;
        logic [3:0]  w_mask;
        logic [PHYS_REG_ADDR_WIDTH-1:0] rd_paddr;
        logic [ROB_ADDR_WIDTH-1:0] rob_addr;
        logic        valid;
        logic [31:0] address_start;
        logic [31:0]    rs1_data;  
        logic [31:0]    rs2_data;
        logic rd_valid;
        logic [2:0]     mem_op;
        logic load_not_store;
    } lsq_t;

    // RVFI mem struct
    typedef struct packed {
        logic [31:0] rvfi_mem_addr;
        logic [3:0]  rvfi_mem_wmask;
        logic [3:0]  rvfi_mem_rmask;
        logic [31:0] rvfi_mem_rdata;
        logic [31:0] rvfi_mem_wdata;
        logic [ROB_ADDR_WIDTH-1:0] rob_addr;
    } rvfi_mem_t;

    // RV32 STANDARD + M -----------------------------------------------------------------------------------

    typedef enum logic [6:0] {
        op_b_lui       = 7'b0110111, // load upper immediate (U type)
        op_b_auipc     = 7'b0010111, // add upper immediate PC (U type)
        op_b_jal       = 7'b1101111, // jump and link (J type)
        op_b_jalr      = 7'b1100111, // jump and link register (I type)
        op_b_br        = 7'b1100011, // branch (B type)
        op_b_load      = 7'b0000011, // load (I type)
        op_b_store     = 7'b0100011, // store (S type)
        op_b_imm       = 7'b0010011, // arith ops with register/immediate operands (I type)
        op_b_reg       = 7'b0110011  // arith ops with register operands (R type)
    } rv32i_opcode;

    typedef enum logic [2:0] {
        arith_f3_add   = 3'b000, // check logic 30 for sub if op_reg op
        arith_f3_sll   = 3'b001,
        arith_f3_slt   = 3'b010,
        arith_f3_sltu  = 3'b011,
        arith_f3_xor   = 3'b100,
        arith_f3_sr    = 3'b101, // check logic 30 for logical/arithmetic
        arith_f3_or    = 3'b110,
        arith_f3_and   = 3'b111
    } arith_f3_t;

    typedef enum logic [2:0] {
        mul_f3_mul      = 3'b000,
        mul_f3_mulh     = 3'b001,
        mul_f3_mulhsu   = 3'b010,
        mul_f3_mulhu    = 3'b011,
        mul_f3_div      = 3'b100,
        mul_f3_divu     = 3'b101,
        mul_f3_rem      = 3'b110,
        mul_f3_remu     = 3'b111
    } mul_f3_t;

    typedef enum logic [2:0] {
        load_f3_lb     = 3'b000,
        load_f3_lh     = 3'b001,
        load_f3_lw     = 3'b010,
        load_f3_lbu    = 3'b100,
        load_f3_lhu    = 3'b101
    } load_f3_t;

    typedef enum logic [2:0] {
        store_f3_sb    = 3'b000,
        store_f3_sh    = 3'b001,
        store_f3_sw    = 3'b010
    } store_f3_t;

    typedef enum logic [2:0] {
        branch_f3_beq  = 3'b000,
        branch_f3_bne  = 3'b001,
        branch_f3_blt  = 3'b100,
        branch_f3_bge  = 3'b101,
        branch_f3_bltu = 3'b110,
        branch_f3_bgeu = 3'b111
    } branch_f3_t;

    typedef enum logic [2:0] {
        f3_op_add_sub  = 3'b000,
        f3_op_sll      = 3'b001,
        f3_op_slt      = 3'b010,
        f3_op_sltu     = 3'b011,
        f3_op_sr       = 3'b101,
        f3_op_xor      = 3'b100,
        f3_op_or       = 3'b110,
        f3_op_and      = 3'b111
    } funct3_t;

    typedef enum logic [6:0] {
        base           = 7'b0000000,
        variant        = 7'b0100000,
        mul            = 7'b0000001
    } funct7_t;

    typedef enum logic [3:0] {
        alu_op_add     = 4'b0000,
        alu_op_sll     = 4'b0001,
        alu_op_slt     = 4'b0010,
        alu_op_sltu    = 4'b0011,
        alu_op_xor     = 4'b0100,
        alu_op_srl     = 4'b0101,
        alu_op_or      = 4'b0110,
        alu_op_and     = 4'b0111,
        alu_op_sub     = 4'b1000,    
        alu_op_sra     = 4'b1101
    } alu_ops;

typedef union packed {
        logic [31:0] word;

        struct packed {
            logic [11:0] i_imm;
            logic [4:0]  rs1;
            logic [2:0]  funct3;
            logic [4:0]  rd;
            rv32i_opcode opcode;
        } i_type;

        struct packed {
            logic [6:0]  funct7;
            logic [4:0]  rs2;
            logic [4:0]  rs1;
            logic [2:0]  funct3;
            logic [4:0]  rd;
            rv32i_opcode opcode;
        } r_type;

        struct packed {
            logic [11:5] imm_s_top;
            logic [4:0]  rs2;
            logic [4:0]  rs1;
            logic [2:0]  funct3;
            logic [4:0]  imm_s_bot;
            rv32i_opcode opcode;
        } s_type;

        struct packed {
            logic [31:12] imm;       
            logic [4:0]   rd;        
            rv32i_opcode  opcode;    
        } u_type;


        struct packed {
            logic        imm_b_msb;
            logic [10:5] imm_b_top;
            logic [4:0]  rs2;
            logic [4:0]  rs1;
            logic [2:0]  funct3;
            logic [3:0]  imm_b_bot;
            logic        imm_b_mid;
            rv32i_opcode opcode;
        } b_type;
        

        struct packed {
            logic [31:12] imm;
            logic [4:0]   rd;
            rv32i_opcode  opcode;
        } j_type;

    } instr_test_t;


endpackage
