module cpu
import rv32i_types::*;
(
    input   logic           clk,
    input   logic           rst,

    output  logic   [31:0]  imem_addr,
    output  logic   [3:0]   imem_rmask,
    input   logic   [31:0]  imem_rdata,
    input   logic           imem_resp,

    output  logic   [31:0]  dmem_addr,
    output  logic   [3:0]   dmem_rmask,
    output  logic   [3:0]   dmem_wmask,
    input   logic   [31:0]  dmem_rdata,
    output  logic   [31:0]  dmem_wdata,
    input   logic           dmem_resp
);

    /* ALU logic */ 
    logic   [2:0]   aluop;
    logic   [31:0]  a;
    logic   [31:0]  b;
    logic   [31:0]  f;
    logic           slts;

    /* regfile logics */
    logic           regf_we;
    logic   [31:0]  rd_v;
    logic   [4:0]   rs1_s, rs2_s, rd_s;
    logic   [31:0]  rs1_v, rs2_v;

    /* forwarding logics */
    logic   [4:0]   freg_1, freg_2;
    logic   [31:0]  fval_1, fval_2;

    /* rvfi_valid signal to test retired instruction */
    valid_t valid_mon; 

    /* stall logic for data memory */
    logic dmem_stall;

    /* flag for magic zero */
    logic magic_zero_flag;
    logic [31:0] branch_target_check_addr;
    logic progress_pc;

    /* used for memory accessing */
    logic [31:0] unalign_addr;

    /* logics for jumps and branches */
    logic [31:0] target_addr;
    logic        taking_branch;
    logic        branch_condition;
    logic [31:0] branch_testor;
    logic        dump_instr;
    logic [31:0] branch_target_after_dump;

    //order cheese
    logic [63:0] last_valid_order;

    //dmem_stall_trail
    logic        dmem_stall_trail;

    /* use after load hazard logic */
    logic   use_after_load;

    /* instantiating the in-between stage registers */
    if_id_stage_reg_t if_id_stage, if_id_stage_next;
    id_ex_stage_reg_t id_ex_stage, id_ex_stage_next;
    ex_mem_stage_reg_t ex_mem_stage, ex_mem_stage_next;
    mem_wb_stage_reg_t mem_wb_stage, mem_wb_stage_next;

    
    /* instantiating pre-fetch logic */ 
    logic [31:0] pc_prev;
    logic [31:0] pc;
    logic [31:0] pc_next;
    logic [31:0] inst;
    logic [63:0] order_prev;
    logic [63:0] order;
    logic [63:0] order_next;
    
    alu alu (
        .*
    );

    regfile regfile (
        .*,
        .valid_wb(mem_wb_stage.valid_instr)
    );

    data_hazard_cntlr data_hazard_cntlr (
        .clk(clk),
        .rst(rst),
        .rs1_s(id_ex_stage_next.a_s), //DETECTION
        .rs2_s(id_ex_stage_next.b_s),
        .rd_s_1(id_ex_stage.rd_s),
        .rd_s_2(ex_mem_stage.rd_s),
        .mem_stage_opcode(id_ex_stage.inst.i_type.opcode),
        .mem_stage_valid(id_ex_stage.valid_instr),
        .wb_stage_opcode(ex_mem_stage.inst.i_type.opcode),
        .wb_stage_valid(mem_wb_stage_next.valid_instr),
        .dmem_stall(dmem_stall),

        .rs1_v(id_ex_stage.a), //FORWARDING
        .rs2_v(id_ex_stage.b),
        .a(a),
        .b(b),
        .mem_stage_aluout(ex_mem_stage.aluout),
        // .mem_stage_dmemout(mem_wb_stage_next.dmem_out),
        .wb_stage_val(rd_v),
        .use_after_load(use_after_load)
    );


    /* always ff that transfers one pipeline stage to the next 
        TODO: eventually this section will need to monitor hazards */
    always_ff @(posedge clk) begin
        if (rst) begin 
            pc    <= 32'haaaaa000;
            pc_prev <= '0;
            order <= '0;
            order_prev <= '0;
            if_id_stage <= '0;
            id_ex_stage <= '0;
            ex_mem_stage <= '0;
            mem_wb_stage <= '0;
            dmem_stall_trail <= '0;
        end 
        // else if (dmem_resp == 0 && (|ex_mem_stage.dmem_rmask)) begin
        else if (dmem_stall) begin
            // pc <= pc_prev;
            pc <= pc;
            pc_prev <= pc_prev;
            order <= order;
            order_prev <= order_prev;
            if_id_stage <= if_id_stage;
            id_ex_stage <= id_ex_stage;
            ex_mem_stage <= ex_mem_stage;
            mem_wb_stage <= mem_wb_stage;
            dmem_stall_trail <= '1;
        end
        else if (use_after_load) begin
            pc <= pc;
            pc_prev <= pc_prev;
            order <= order;
            order_prev <= order_prev;
            if_id_stage <= if_id_stage;
            id_ex_stage <= id_ex_stage;
            ex_mem_stage <= '0;
            mem_wb_stage <= mem_wb_stage_next;
            dmem_stall_trail <= '0;
        end
        else begin 
            pc <= pc_next;
            pc_prev <= (taking_branch) ? target_addr : pc;
            order <= order_next;
            order_prev <= (taking_branch) ? order_prev - 'd1 : order;
            if_id_stage <= if_id_stage_next;
            id_ex_stage <= id_ex_stage_next;
            ex_mem_stage <= ex_mem_stage_next;
            mem_wb_stage <= mem_wb_stage_next;
            dmem_stall_trail <= '0;
        end
    end

    always_ff @(posedge clk) begin
        if (rst) begin
            dump_instr <= '0;
        end else if(!imem_resp && taking_branch) begin
            dump_instr <= '1;
        end else if (imem_resp) begin
            dump_instr <= '0;
        end else begin
            dump_instr <= dump_instr;
        end
    end

    always_ff @(posedge clk) begin
        if (rst) begin
            branch_target_after_dump <= '0;
        end else if(!imem_resp && taking_branch) begin
            branch_target_after_dump <= target_addr;
        end else if (!dump_instr) begin
            branch_target_after_dump <= '0;
        end else begin
            branch_target_after_dump <= branch_target_after_dump;
        end
    end

    always_ff @(posedge clk) begin
        if (rst) begin
            last_valid_order <= '0;
        end else if (mem_wb_stage.valid_instr) begin
            last_valid_order <= last_valid_order+'d1;
        end else begin
            last_valid_order <= last_valid_order;
        end
    end

    always_ff @(posedge clk) begin
        if (rst) begin
            magic_zero_flag <= '0;
        end else if (!imem_resp) begin
            magic_zero_flag <= '1;
        end else begin
            magic_zero_flag <= magic_zero_flag;
        end
    end

    /* pre-fetch */
    always_comb begin
        imem_addr = (use_after_load) ? pc_prev : (taking_branch) ? target_addr : pc;
        imem_rmask = 4'b1111;
        if (magic_zero_flag) begin
            if(imem_resp && progress_pc) begin
                pc_next = (use_after_load) ? pc + 'd4 : (taking_branch) ? target_addr + 'd4 : pc + 'd4;
                order_next = (use_after_load) ? order + 'd1 : (taking_branch) ? order - 'd1 : order + 'd1;
            end else begin
                pc_next = (taking_branch) ? target_addr : pc;
                order_next = (dmem_stall_trail) ? order + 'd1 : order;
            end
        end else begin
            if(imem_resp && !(pc_prev == if_id_stage.pc && if_id_stage.inst == imem_rdata && if_id_stage.order == order_prev)) begin
                pc_next = (use_after_load) ? pc + 'd4 : (taking_branch) ? target_addr + 'd4 : pc + 'd4;
                order_next = (use_after_load) ? order + 'd1 : (taking_branch) ? order - 'd1 : order + 'd1;
            end else begin
                pc_next = (taking_branch) ? target_addr : pc;
                order_next = (dmem_stall_trail) ? order + 'd1 : order;
            end
        end
    end
   
    assign branch_target_check_addr = (magic_zero_flag) ? branch_target_after_dump : ex_mem_stage.branch_target;
    assign progress_pc = (taking_branch || dump_instr || (pc_prev == if_id_stage.pc && pc_prev != branch_target_check_addr)) ? invalid : valid;
    //fetch
    always_comb begin
        if(imem_resp) begin
            if_id_stage_next.inst = imem_rdata;
            if_id_stage_next.pc = pc_prev;
            if_id_stage_next.order = order_prev;
            rs1_s = (use_after_load || dmem_stall) ? if_id_stage.inst.r_type.rs1 : if_id_stage_next.inst.r_type.rs1;
            rs2_s = (use_after_load || dmem_stall) ? if_id_stage.inst.r_type.rs2 : if_id_stage_next.inst.r_type.rs2;
            if (rst || !(|pc_prev) || taking_branch || dump_instr) begin 
                if_id_stage_next.valid_instr = invalid;
            end else begin
                if_id_stage_next.valid_instr = (pc_prev == if_id_stage.pc && pc_prev != branch_target_check_addr) ? invalid : valid;
            end
        end else begin
            if_id_stage_next.inst = '0; 
            if_id_stage_next.pc = '0;
            if_id_stage_next.order = '0;
            rs1_s = (dmem_stall_trail) ? if_id_stage.inst.r_type.rs1 : '0;
            rs2_s = (dmem_stall_trail) ? if_id_stage.inst.r_type.rs2 : '0;
            if_id_stage_next.valid_instr = invalid;
        end
    end

    /* decode */
    always_comb begin
        unique case (if_id_stage.valid_instr)
            valid : begin
                id_ex_stage_next.inst = if_id_stage.inst;
                id_ex_stage_next.pc = if_id_stage.pc;
                id_ex_stage_next.order = if_id_stage.order;
                id_ex_stage_next.valid_instr = (taking_branch) ? invalid : if_id_stage.valid_instr;

                /* TODO: modify each case to pass the correct values to alu etc. */
                unique case (if_id_stage.inst.i_type.opcode)
                    op_b_lui  : begin
                        id_ex_stage_next.a = 32'h00000000;
                        id_ex_stage_next.b = {if_id_stage.inst[31:12], 12'h000};
                        id_ex_stage_next.imm = {if_id_stage.inst[31:12], 12'h000};
                        id_ex_stage_next.funct3 = '0;
                        id_ex_stage_next.funct7 = '0;
                        id_ex_stage_next.a_s = '0;
                        id_ex_stage_next.b_s = '0;
                        id_ex_stage_next.rd_s = if_id_stage.inst.j_type.rd;
                        id_ex_stage_next.unaligned_addr = '0;
                    end
                    op_b_auipc: begin
                        id_ex_stage_next.a = if_id_stage.pc;
                        id_ex_stage_next.b = {if_id_stage.inst[31:12], 12'h000};
                        id_ex_stage_next.imm = {if_id_stage.inst[31:12], 12'h000};
                        id_ex_stage_next.funct3 = '0;
                        id_ex_stage_next.funct7 = '0;
                        id_ex_stage_next.a_s = '0;
                        id_ex_stage_next.b_s = '0;
                        id_ex_stage_next.rd_s = if_id_stage.inst.j_type.rd;
                        id_ex_stage_next.unaligned_addr = '0;
                    end
                    op_b_jal  : begin
                        id_ex_stage_next.a = if_id_stage.pc;
                        id_ex_stage_next.b = '0;
                        id_ex_stage_next.imm = {{12{if_id_stage.inst[31]}}, if_id_stage.inst[19:12], if_id_stage.inst[20], if_id_stage.inst[30:21], 1'b0};
                        id_ex_stage_next.funct3 = '0;
                        id_ex_stage_next.funct7 = '0;
                        id_ex_stage_next.a_s = '0;
                        id_ex_stage_next.b_s = '0;
                        id_ex_stage_next.rd_s = if_id_stage.inst.j_type.rd;
                        id_ex_stage_next.unaligned_addr = '0;
                    end
                    op_b_jalr : begin
                        id_ex_stage_next.a = (if_id_stage.inst.i_type.rs1 == rd_s && mem_wb_stage.valid_instr) ? rd_v : rs1_v; 
                        id_ex_stage_next.b = '0;
                        id_ex_stage_next.imm = {{21{if_id_stage.inst[31]}}, if_id_stage.inst[30:20]};
                        id_ex_stage_next.funct3 = '0;
                        id_ex_stage_next.funct7 = '0;
                        id_ex_stage_next.a_s = if_id_stage.inst.i_type.rs1;
                        id_ex_stage_next.b_s = '0;
                        id_ex_stage_next.rd_s = if_id_stage.inst.i_type.rd;
                        id_ex_stage_next.unaligned_addr = '0;
                    end
                    op_b_br   : begin
                        id_ex_stage_next.a = (if_id_stage.inst.b_type.rs1 == rd_s && mem_wb_stage.valid_instr) ? rd_v : rs1_v; 
                        id_ex_stage_next.b = (if_id_stage.inst.b_type.rs2 == rd_s && mem_wb_stage.valid_instr) ? rd_v : rs2_v; 
                        id_ex_stage_next.imm = {{20{if_id_stage.inst[31]}}, if_id_stage.inst[7], if_id_stage.inst[30:25], if_id_stage.inst[11:8], 1'b0};
                        id_ex_stage_next.funct3 = if_id_stage.inst.b_type.funct3;
                        id_ex_stage_next.funct7 = '0;
                        id_ex_stage_next.a_s = if_id_stage.inst.b_type.rs1;
                        id_ex_stage_next.b_s = if_id_stage.inst.b_type.rs2;
                        id_ex_stage_next.rd_s = '0;
                        id_ex_stage_next.unaligned_addr = '0;
                    end
                    op_b_load : begin
                        id_ex_stage_next.a = (if_id_stage.inst.i_type.rs1 == rd_s && mem_wb_stage.valid_instr) ? rd_v : rs1_v; 
                        id_ex_stage_next.b = '0;
                        id_ex_stage_next.imm = {{21{if_id_stage.inst[31]}}, if_id_stage.inst[30:20]};
                        id_ex_stage_next.funct3 = if_id_stage.inst.i_type.funct3;
                        id_ex_stage_next.funct7 = '0;
                        id_ex_stage_next.a_s = if_id_stage.inst.i_type.rs1;
                        id_ex_stage_next.b_s = '0;
                        id_ex_stage_next.rd_s = if_id_stage.inst.i_type.rd;
                        id_ex_stage_next.unaligned_addr = rs1_v + id_ex_stage_next.imm;
                    end
                    op_b_store: begin
                        id_ex_stage_next.a = (if_id_stage.inst.s_type.rs1 == rd_s && mem_wb_stage.valid_instr) ? rd_v : rs1_v;  
                        id_ex_stage_next.b = (if_id_stage.inst.s_type.rs2 == rd_s && mem_wb_stage.valid_instr) ? rd_v : rs2_v; 
                        id_ex_stage_next.imm = {{21{if_id_stage.inst.s_type.imm_s_top[11]}}, if_id_stage.inst.s_type.imm_s_top[10:5], if_id_stage.inst.s_type.imm_s_bot};
                        id_ex_stage_next.funct3 = if_id_stage.inst.s_type.funct3;
                        id_ex_stage_next.funct7 = '0;
                        id_ex_stage_next.a_s = if_id_stage.inst.s_type.rs1;
                        id_ex_stage_next.b_s = if_id_stage.inst.s_type.rs2;
                        id_ex_stage_next.rd_s = '0;
                        id_ex_stage_next.unaligned_addr = rs1_v + id_ex_stage_next.imm;
                    end
                    op_b_imm  : begin
                        id_ex_stage_next.a = (if_id_stage.inst.i_type.rs1 == rd_s && mem_wb_stage.valid_instr) ? rd_v : rs1_v; 
                        if (if_id_stage.inst.i_type.funct3 == 3'b001 || if_id_stage.inst.i_type.funct3 == 3'b101) begin
                            id_ex_stage_next.b = {27'd0, if_id_stage.inst[24:20]};
                            id_ex_stage_next.imm = {27'd0, if_id_stage.inst[24:20]};
                            id_ex_stage_next.funct7 = if_id_stage.inst.r_type.funct7; 
                        end else begin
                            id_ex_stage_next.b = {{21{if_id_stage.inst[31]}}, if_id_stage.inst[30:20]};
                            id_ex_stage_next.imm = {{21{if_id_stage.inst[31]}}, if_id_stage.inst[30:20]};
                            id_ex_stage_next.funct7 = '0; 
                        end
                        id_ex_stage_next.funct3 = if_id_stage.inst.i_type.funct3;
                        id_ex_stage_next.a_s = if_id_stage.inst.i_type.rs1;
                        id_ex_stage_next.b_s = '0;
                        id_ex_stage_next.rd_s = if_id_stage.inst.i_type.rd;
                        id_ex_stage_next.unaligned_addr = '0;
                    end
                    op_b_reg  : begin
                        id_ex_stage_next.a = (if_id_stage.inst.r_type.rs1 == rd_s && mem_wb_stage.valid_instr) ? rd_v : rs1_v; 
                        id_ex_stage_next.b = (if_id_stage.inst.r_type.rs2 == rd_s && mem_wb_stage.valid_instr) ? rd_v : rs2_v; 
                        id_ex_stage_next.imm = '0;
                        id_ex_stage_next.funct3 = if_id_stage.inst.r_type.funct3;
                        id_ex_stage_next.funct7 = if_id_stage.inst.r_type.funct7;
                        id_ex_stage_next.a_s = if_id_stage.inst.r_type.rs1;
                        id_ex_stage_next.b_s = if_id_stage.inst.r_type.rs2;
                        id_ex_stage_next.rd_s = if_id_stage.inst.r_type.rd;
                        id_ex_stage_next.unaligned_addr = '0;
                    end
                    default   : begin
                        id_ex_stage_next.a = '0;
                        id_ex_stage_next.b = '0;
                        id_ex_stage_next.imm = '0;
                        id_ex_stage_next.funct3 = '0;
                        id_ex_stage_next.funct7 = '0;
                        id_ex_stage_next.a_s = '0;
                        id_ex_stage_next.b_s = '0;
                        id_ex_stage_next.rd_s = '0;
                        id_ex_stage_next.unaligned_addr = '0;
                    end
                endcase
            end
            invalid: begin
                id_ex_stage_next.inst = if_id_stage.inst;
                id_ex_stage_next.pc = if_id_stage.pc;
                id_ex_stage_next.order = if_id_stage.order;
                id_ex_stage_next.a = id_ex_stage.a;
                id_ex_stage_next.b = id_ex_stage.b;
                id_ex_stage_next.imm = id_ex_stage.imm;
                id_ex_stage_next.funct3 = id_ex_stage.funct3;
                id_ex_stage_next.funct7 = '0;
                id_ex_stage_next.a_s = '0;
                id_ex_stage_next.b_s = '0;
                id_ex_stage_next.rd_s = '0;
                id_ex_stage_next.valid_instr = if_id_stage.valid_instr;
                id_ex_stage_next.unaligned_addr = id_ex_stage.unaligned_addr;
                // id_ex_stage_next.unaligned_addr = '0;
            end
        endcase
    end

    //WHY DID THIS WORK BUT NOT COMB BLOCK????
    assign ex_mem_stage_next.dmem_addr = dmem_addr;
    assign ex_mem_stage_next.dmem_rmask = dmem_rmask;
    assign ex_mem_stage_next.dmem_wmask = dmem_wmask;
    assign ex_mem_stage_next.dmem_wdata = dmem_wdata;
    assign ex_mem_stage_next.branch_taken = taking_branch;
    assign ex_mem_stage_next.branch_target = (taking_branch) ? target_addr : '0;
    assign branch_testor = a - b;
    assign unalign_addr = a + id_ex_stage.imm;
    assign target_addr = (id_ex_stage.inst.i_type.opcode[2] == 1'b1) ? (a + id_ex_stage.imm)&32'hfffffffe : (id_ex_stage.pc + id_ex_stage.imm)&32'hfffffffe;
    assign taking_branch = (id_ex_stage.inst.i_type.opcode[6] && id_ex_stage.valid_instr) ? 
                            ((id_ex_stage.inst.i_type[2]) ? 1'b1 : 
                            (branch_condition ? 1'b1 : 1'b0)) : 1'b0;
    assign ex_mem_stage_next.combined_mask = |(dmem_rmask | dmem_wmask);

    /* execute */
    always_comb begin
        ex_mem_stage_next.inst = id_ex_stage.inst;
        ex_mem_stage_next.pc = id_ex_stage.pc;
        ex_mem_stage_next.order = id_ex_stage.order;
        ex_mem_stage_next.valid_instr = id_ex_stage.valid_instr;
        ex_mem_stage_next.a = a;
        ex_mem_stage_next.b = b;
        ex_mem_stage_next.imm = id_ex_stage.imm;
        ex_mem_stage_next.funct3 = id_ex_stage.funct3;
        ex_mem_stage_next.funct7 = id_ex_stage.funct7;
        ex_mem_stage_next.a_s = id_ex_stage.a_s;
        ex_mem_stage_next.b_s = id_ex_stage.b_s;
        ex_mem_stage_next.rd_s = id_ex_stage.rd_s;

        ex_mem_stage_next.aligned_addr = {unalign_addr[31:2], 2'b00};
        ex_mem_stage_next.addr_offset = unalign_addr[1:0];

        ex_mem_stage_next.aluout = f;

        // if(id_ex_stage.inst.i_type.opcode[6] && id_ex_stage.valid_instr) begin //is opcode a jump or branch
        //     if(id_ex_stage.inst.i_type.opcode[2]) begin //its a jump
        //         taking_branch = 1'b1;
        //     end
        //     else begin //its a branch
        //         if (branch_condition) begin
        //             taking_branch = 1'b1;
        //         end else begin
        //             taking_branch = 1'b0;
        //         end
        //     end
        // end else begin
        //     taking_branch = 1'b0;
        // end

        /* determine if the branch condition is met */
        unique case (id_ex_stage.funct3) 
            branch_f3_beq: branch_condition = (|branch_testor) ? '0 : '1;
            branch_f3_bne: branch_condition = (|branch_testor) ? '1 : '0;
            // branch_f3_blt: branch_condition = (branch_testor[31]) ? '1 : '0;
            // branch_f3_bge: branch_condition = (branch_testor[31]) ? '0 : '1;
            branch_f3_blt: branch_condition = (a[31] != b[31]) ? ((a[31]) ? '1 : '0) : ((a < b) ? '1 : '0);
            branch_f3_bge: branch_condition = (a[31] != b[31]) ? ((a[31]) ? '0 : '1) : ((a < b) ? '0 : '1);
            branch_f3_bltu: branch_condition = (a<b) ? '1 : '0;
            branch_f3_bgeu: branch_condition = (a<b) ? '0 : '1;
            default       : branch_condition = '0;
        endcase

        unique case (id_ex_stage.funct3)
            f3_op_add_sub  : begin
                if (id_ex_stage.funct7 == variant) begin
                    aluop = alu_op_sub;
                end else begin
                    aluop = alu_op_add;
                end
                slts = '0;
            end
            f3_op_sr       : begin
                if (id_ex_stage.funct7 == variant) begin
                    aluop = alu_op_sra;
                end else begin
                    aluop = alu_op_srl; 
                end
                slts = '0;
            end
            f3_op_slt      : begin
                aluop = id_ex_stage.funct3;
                slts = '1;
            end
            f3_op_sltu     : begin
                aluop = id_ex_stage.funct3;
                slts = '1;
            end
            default        : begin
                aluop = id_ex_stage.funct3;
                slts = '0;
            end 
        endcase
        
        if(id_ex_stage.valid_instr) begin
            unique case (id_ex_stage.inst.s_type.opcode)
                op_b_load : begin 
                    dmem_addr = ex_mem_stage_next.aligned_addr;
                    unique case (id_ex_stage.funct3)
                        load_f3_lb : begin
                            unique case (ex_mem_stage_next.addr_offset)
                                2'b00 : dmem_rmask = 4'b0001;
                                2'b01 : dmem_rmask = 4'b0010;
                                2'b10 : dmem_rmask = 4'b0100;
                                2'b11 : dmem_rmask = 4'b1000;
                            endcase
                        end
                        load_f3_lh : begin
                            unique case (ex_mem_stage_next.addr_offset)
                                2'b00 : dmem_rmask = 4'b0011;
                                2'b01 : dmem_rmask = 4'b0110;
                                2'b10 : dmem_rmask = 4'b1100;
                                2'b11 : dmem_rmask = 4'b1001; //not sure
                            endcase
                        end
                        load_f3_lw : begin
                            dmem_rmask = '1;
                        end
                        load_f3_lbu: begin
                            unique case (ex_mem_stage_next.addr_offset)
                                2'b00 : dmem_rmask = 4'b0001;
                                2'b01 : dmem_rmask = 4'b0010;
                                2'b10 : dmem_rmask = 4'b0100;
                                2'b11 : dmem_rmask = 4'b1000;
                            endcase
                        end
                        load_f3_lhu: begin
                            unique case (ex_mem_stage_next.addr_offset)
                                2'b00 : dmem_rmask = 4'b0011;
                                2'b01 : dmem_rmask = 4'b0110;
                                2'b10 : dmem_rmask = 4'b1100;
                                2'b11 : dmem_rmask = 4'b1001; //not sure
                            endcase
                        end
                        default : dmem_rmask = '0; //invalid
                    endcase
                    dmem_wmask = '0;
                    dmem_wdata = 'x;
                end
                op_b_store : begin
                    dmem_addr = ex_mem_stage_next.aligned_addr;
                    unique case (ex_mem_stage_next.addr_offset)
                        2'b00 : dmem_wdata = b;
                        2'b01 : dmem_wdata = b<<8;
                        2'b10 : dmem_wdata = b<<16;
                        2'b11 : dmem_wdata = b<<24;
                    endcase
                    unique case (id_ex_stage.funct3)
                        store_f3_sb : begin
                            unique case (ex_mem_stage_next.addr_offset)
                                2'b00 : dmem_wmask = 4'b0001;
                                2'b01 : dmem_wmask = 4'b0010;
                                2'b10 : dmem_wmask = 4'b0100;
                                2'b11 : dmem_wmask = 4'b1000;
                            endcase
                        end
                        store_f3_sh : begin
                            unique case (ex_mem_stage_next.addr_offset)
                                2'b00 : dmem_wmask = 4'b0011;
                                2'b01 : dmem_wmask = 4'b0110;
                                2'b10 : dmem_wmask = 4'b1100;
                                2'b11 : dmem_wmask = 4'b1001;
                            endcase
                        end
                        store_f3_sw : dmem_wmask = '1;
                        default : dmem_wmask = '0; //invalid
                    endcase
                    dmem_rmask = '0;
                end
                default : begin
                    dmem_addr = 'x;
                    dmem_rmask = '0;
                    dmem_wmask = '0;
                    dmem_wdata = 'x;
                end
            endcase
        end else begin
            dmem_addr = 'x;
            dmem_rmask = '0;
            dmem_wmask = '0;
            dmem_wdata = 'x;
        end
    end

    /* memory */
    always_comb begin
        mem_wb_stage_next.inst = ex_mem_stage.inst;
        mem_wb_stage_next.pc = ex_mem_stage.pc;
        mem_wb_stage_next.order = ex_mem_stage.order;
        mem_wb_stage_next.a = ex_mem_stage.a;
        mem_wb_stage_next.b = ex_mem_stage.b;
        mem_wb_stage_next.imm = ex_mem_stage.imm;
        mem_wb_stage_next.funct3 = ex_mem_stage.funct3;
        mem_wb_stage_next.funct7 = ex_mem_stage.funct7;
        mem_wb_stage_next.a_s = ex_mem_stage.a_s;
        mem_wb_stage_next.b_s = ex_mem_stage.b_s;
        mem_wb_stage_next.rd_s = ex_mem_stage.rd_s;

        mem_wb_stage_next.aluout = ex_mem_stage.aluout;
        
        mem_wb_stage_next.dmem_addr = ex_mem_stage.dmem_addr;
        mem_wb_stage_next.dmem_rmask = ex_mem_stage.dmem_rmask;
        mem_wb_stage_next.dmem_wmask = ex_mem_stage.dmem_wmask;
        mem_wb_stage_next.dmem_rdata = dmem_rdata;
        mem_wb_stage_next.dmem_wdata = ex_mem_stage.dmem_wdata;
        mem_wb_stage_next.aligned_addr = ex_mem_stage.aligned_addr;
        mem_wb_stage_next.addr_offset = ex_mem_stage.addr_offset;

        mem_wb_stage_next.branch_taken = ex_mem_stage.branch_taken;
        mem_wb_stage_next.branch_target = ex_mem_stage.branch_target;

        // mem_wb_stage_next.valid_instr = ex_mem_stage.valid_instr;
        
        //((|ex_mem_stage.dmem_rmask) || (|ex_mem_stage.dmem_wmask))
        if(dmem_resp == 0 && ex_mem_stage.combined_mask) begin
            mem_wb_stage_next.valid_instr = invalid;
            dmem_stall = '1;
        end else begin
            mem_wb_stage_next.valid_instr = ex_mem_stage.valid_instr;
            dmem_stall = '0;
        end

        unique case (ex_mem_stage.inst.i_type.opcode)
            op_b_load : begin 
                if(dmem_resp) begin 
                    unique case (ex_mem_stage.funct3)
                        load_f3_lb : begin
                            unique case (ex_mem_stage.addr_offset)
                                2'b00 : mem_wb_stage_next.dmem_out = {{25{dmem_rdata[7]}},dmem_rdata[6:0]};
                                2'b01 : mem_wb_stage_next.dmem_out = {{25{dmem_rdata[15]}},dmem_rdata[14:8]};
                                2'b10 : mem_wb_stage_next.dmem_out = {{25{dmem_rdata[23]}},dmem_rdata[22:16]};
                                2'b11 : mem_wb_stage_next.dmem_out = {{25{dmem_rdata[31]}},dmem_rdata[30:24]};
                            endcase
                        end 
                        load_f3_lh : begin
                            unique case (ex_mem_stage.addr_offset)
                                2'b00 : mem_wb_stage_next.dmem_out = {{17{dmem_rdata[15]}},dmem_rdata[14:0]};
                                2'b01 : mem_wb_stage_next.dmem_out = {{17{dmem_rdata[23]}},dmem_rdata[22:8]};
                                2'b10 : mem_wb_stage_next.dmem_out = {{17{dmem_rdata[31]}},dmem_rdata[30:16]};
                                2'b11 : mem_wb_stage_next.dmem_out = {{17{dmem_rdata[7]}},dmem_rdata[6:0],dmem_rdata[31:24]};
                            endcase
                        end
                        load_f3_lw : mem_wb_stage_next.dmem_out = dmem_rdata;
                        load_f3_lbu: begin
                            unique case (ex_mem_stage.addr_offset)
                                2'b00 : mem_wb_stage_next.dmem_out = {24'h000000,dmem_rdata[7:0]};
                                2'b01 : mem_wb_stage_next.dmem_out = {24'h000000,dmem_rdata[15:8]};
                                2'b10 : mem_wb_stage_next.dmem_out = {24'h000000,dmem_rdata[23:16]};
                                2'b11 : mem_wb_stage_next.dmem_out = {24'h000000,dmem_rdata[31:24]};
                            endcase
                        end 
                        load_f3_lhu: begin
                            unique case (ex_mem_stage.addr_offset)
                                2'b00 : mem_wb_stage_next.dmem_out = {16'h0000,dmem_rdata[15:0]};
                                2'b01 : mem_wb_stage_next.dmem_out = {16'h0000,dmem_rdata[23:8]};
                                2'b10 : mem_wb_stage_next.dmem_out = {16'h0000,dmem_rdata[31:16]};
                                2'b11 : mem_wb_stage_next.dmem_out = {16'h0000,dmem_rdata[7:0],dmem_rdata[31:24]};
                            endcase
                        end 
                        default : mem_wb_stage_next.dmem_out = '0; //invalid instr
                    endcase
                end else begin
                    mem_wb_stage_next.dmem_out = '0; //we're supposed to read?
                end
            end
            op_b_store : mem_wb_stage_next.dmem_out = '0; //might need to confirm that store worked using resp
            default : mem_wb_stage_next.dmem_out = '0;
        endcase
    end

    /* write-back */
    always_comb begin
        if ((mem_wb_stage.inst.i_type.opcode != op_b_br) && (mem_wb_stage.inst.i_type.opcode != op_b_store)
            && (mem_wb_stage.inst != 32'h00000013) && (mem_wb_stage.valid_instr)) begin
            regf_we = '1;
        end else begin
            regf_we = '0;
        end
        if(mem_wb_stage.valid_instr == valid) begin
            valid_mon = valid;
        end else begin
            valid_mon = invalid;
        end
        rd_s = mem_wb_stage.rd_s;
        if (mem_wb_stage.inst.i_type.opcode == op_b_load) begin
            rd_v = (rd_s == '0) ? '0 : mem_wb_stage.dmem_out;
        end else begin
            rd_v = (rd_s == '0) ? '0 : (mem_wb_stage.inst.i_type.opcode[6] && mem_wb_stage.inst.i_type.opcode[2]) ? mem_wb_stage.pc + 'd4 : mem_wb_stage.aluout;
        end
    end





    /* rvfi monitor port */
    logic [63:0] order_mon      ; 
    logic [31:0] inst_mon; 
    logic [4:0] rs1_addr_mon   ; 
    logic [4:0] rs2_addr_mon   ; 
    logic [31:0] rs1_rdata_mon  ; 
    logic [31:0] rs2_rdata_mon  ; 
    logic [4:0] rd_addr_mon    ; 
    logic [31:0] rd_wdata_mon   ; 
    logic [31:0] pc_rdata_mon   ; 
    logic [31:0] pc_wdata_mon   ; 
    logic [31:0] mem_addr_mon   ; 
    logic [3:0] mem_rmask_mon  ;
    logic [3:0] mem_wmask_mon  ;
    logic [31:0] mem_rdata_mon  ;
    logic [31:0] mem_wdata_mon  ;
    always_comb begin
        // order_mon      =   mem_wb_stage.order;
        order_mon = last_valid_order;
        inst_mon       =   mem_wb_stage.inst;
        rs1_addr_mon   =   mem_wb_stage.a_s;
        rs2_addr_mon   =   mem_wb_stage.b_s;
        rs1_rdata_mon  =   mem_wb_stage.a;
        rs2_rdata_mon  =   mem_wb_stage.b;
        rd_addr_mon    =   mem_wb_stage.rd_s;
        if (mem_wb_stage.inst.i_type.opcode == op_b_load) begin
            rd_wdata_mon   =   mem_wb_stage.dmem_out;
        end else begin
            rd_wdata_mon   =   (mem_wb_stage.inst.i_type.opcode[6] && mem_wb_stage.inst.i_type.opcode[2]) ? mem_wb_stage.pc + 'd4 : mem_wb_stage.aluout;
        end
        pc_rdata_mon   =   mem_wb_stage.pc;
        if (mem_wb_stage.inst.i_type.opcode[6] == 1'b1) begin
            if (mem_wb_stage.inst.i_type.opcode[2] == 1'b1) begin
                // pc_wdata_mon = (pc_rdata_mon == mem_wb_stage.aluout) ? mem_wb_stage.aluout + 'd4 : mem_wb_stage.aluout;
                pc_wdata_mon = mem_wb_stage.branch_target;
            end else begin // it was a branch
                pc_wdata_mon = (mem_wb_stage.branch_taken) ? mem_wb_stage.branch_target : mem_wb_stage.pc + 'd4;
            end
        end else begin
            pc_wdata_mon = mem_wb_stage.pc + 'd4;
        end 
        mem_addr_mon   =   mem_wb_stage.dmem_addr;
        mem_rmask_mon  =   mem_wb_stage.dmem_rmask;
        mem_wmask_mon  =   mem_wb_stage.dmem_wmask;
        mem_rdata_mon  =   mem_wb_stage.dmem_rdata;
        mem_wdata_mon  =   mem_wb_stage.dmem_wdata;
    end
    

endmodule : cpu
