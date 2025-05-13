module reservation_stations
import rv32i_types::*;
#(
    parameter DEPTH = 4 //essentially the # of stations per functional unit (should be (b)it addressible size)
)(
    input logic                         rst,
    input logic                         clk,

    // instr and web from dispatch stage
    input logic [3:0]                   rs_web, //TODO: confirm this only goes high when the instruction in dispatch is valid        
    input instr_t                       inst_pkt,

    // rs1_paddr and rs2_paddr from rat_arf if valid for that reg is low
    input logic [DEPTH-1:0] rs1_paddr,
    input logic [DEPTH-1:0] rs2_paddr,

    // inputs from the respective functional units
    input logic             arith_fu_ready,
    input logic             mem_fu_ready,
    input logic             br_fu_ready,
    input logic             mul_div_fu_ready,

    // inputs from the common data bus | TODO: for now we will only port one paddr that is completed per clock cycle
    input cdb_t             bus_wb,

    // outputs to the dispatch stage to communicate is RS's are full
    output logic            arith_rs_full,
    output logic            mem_rs_full,
    output logic            br_rs_full,
    output logic            mul_div_rs_full,

    // outputs to each respective functional unit
    output instr_t          arith_instr_pkt,
    output logic            arith_instr_pkt_rdy,
    output instr_t          mem_instr_pkt,
    output logic            mem_instr_pkt_rdy,
    output instr_t          br_instr_pkt,
    output logic            br_instr_pkt_rdy,
    output instr_t          mul_div_instr_pkt,
    output logic            mul_div_instr_pkt_rdy

);
/*
 *
 *
 REDACTED FILE REPLACED BY RS_FIFO.SV + ISSUE STAGE TO BETTER READIBILITY
 *
 *
 */
localparam ADDR_WIDTH = $clog2(DEPTH);

// 4 sets of RSs, alu-mem-br-mult_div, subject to adding more
rs_t    arith_rs   [DEPTH];
rs_t    mem_rs     [DEPTH];
rs_t    br_rs      [DEPTH];
rs_t    mul_div_rs [DEPTH];

// logics which tell if an instr in the rs can be sent to its function unit
logic arith_instr_ready;
logic mem_instr_ready;
logic br_instr_ready;
logic mul_div_instr_ready;

// fifo queue logics for rs's
logic [ADDR_WIDTH-1:0] arith_rs_head;
logic [ADDR_WIDTH-1:0] arith_rs_tail;
logic arith_inc_count;
logic arith_dec_count;
logic [ADDR_WIDTH-1:0] arith_count; 
logic allow_arith_inc;
logic allow_arith_dec;

logic [ADDR_WIDTH-1:0] mem_rs_head;
logic [ADDR_WIDTH-1:0] mem_rs_tail;
logic mem_inc_count;
logic mem_dec_count;
logic [ADDR_WIDTH-1:0] mem_count;
logic allow_mem_inc;
logic allow_mem_dec; 

logic [ADDR_WIDTH-1:0] br_rs_head;
logic [ADDR_WIDTH-1:0] br_rs_tail;
logic br_inc_count;
logic br_dec_count;
logic [ADDR_WIDTH-1:0] br_count;
logic allow_br_inc;
logic allow_br_dec; 

logic [ADDR_WIDTH-1:0] mul_div_rs_head;
logic [ADDR_WIDTH-1:0] mul_div_rs_tail;
logic mul_div_inc_count;
logic mul_div_dec_count;
logic [ADDR_WIDTH-1:0] mul_div_count; 
logic allow_mul_div_inc;
logic allow_mul_div_dec;

logic [ADDR_WIDTH-1:0] full_count; //currently the size of all reservations stations will be the same
assign allow_arith_inc = (arith_count < full_count && rs_web[0]);
assign allow_mem_inc = (mem_count < full_count && rs_web[1]);
assign allow_br_inc = (br_count < full_count && rs_web[2]);
assign allow_mul_div_inc = (mul_div_count < full_count && rs_web[3]);

assign allow_arith_dec = (arith_fu_ready && arith_instr_ready);
assign allow_mem_dec = (mem_fu_ready && mem_instr_ready);
assign allow_br_dec = (br_fu_ready && br_instr_ready);
assign allow_mul_div_dec = (mul_div_fu_ready && mul_div_instr_ready);

assign full_count = '1;       //so we only need 1 full_count

// the next rs packet
rs_t    rs_pkt_next;

always_comb begin : rs_packet_construction
    rs_pkt_next.inst_pkt = inst_pkt;
    rs_pkt_next.valid = VALID; // we are about to allocate this rs_pkt to an entry
    rs_pkt_next.rs1_paddr = rs1_paddr; 
    rs_pkt_next.rs2_paddr = rs2_paddr; 
end

// TODO: make sure this works
// RS's queue and control logics
always_ff @(posedge clk) begin
    if (rst) begin
        arith_rs_head <= '0;
        mem_rs_head <= '0;
        br_rs_head <= '0;
        mul_div_rs_head <= '0;

        arith_rs_tail <= '0;
        mem_rs_tail <= '0;
        br_rs_tail <= '0;
        mul_div_rs_tail <= '0;

        arith_rs_full <= '0;
        mem_rs_full <= '0;
        br_rs_full <= '0;
        mul_div_rs_full <= '0;

        arith_count <= '0;
        mem_count <= '0;
        br_count <= '0;
        mul_div_count <= '0;
    end else begin
        // determine if the RSs are full
        if (arith_count < full_count) begin 
            arith_rs_full <= '0;
        end else begin 
            arith_rs_full <= '1;
        end
        if (mem_count < full_count) begin 
            mem_rs_full <= '0;
        end else begin 
            mem_rs_full <= '1;
        end
        if (br_count < full_count) begin 
            br_rs_full <= '0;
        end else begin 
            br_rs_full <= '1;
        end
        if (mul_div_count < full_count) begin 
            mul_div_rs_full <= '0;
        end else begin 
            mul_div_rs_full <= '1;
        end

        // update the tails of each RS
        if (allow_arith_inc) begin
            arith_rs_tail <= arith_rs_tail + ADDR_WIDTH'(1);
        end else begin
            arith_rs_tail <= arith_rs_tail;
        end
        if (allow_mem_inc) begin
            mem_rs_tail <= mem_rs_tail + ADDR_WIDTH'(1);
        end else begin
            mem_rs_tail <= mem_rs_tail;
        end
        if (allow_br_inc) begin
            br_rs_tail <= br_rs_tail + ADDR_WIDTH'(1);
        end else begin
            br_rs_tail <= br_rs_tail;
        end
        if (allow_mul_div_inc) begin
            mul_div_rs_tail <= mul_div_rs_tail + ADDR_WIDTH'(1);
        end else begin
            mul_div_rs_tail <= mul_div_rs_tail;
        end

        // update the heads of each RS
        if (allow_arith_dec) begin
            arith_rs_head <= arith_rs_head + ADDR_WIDTH'(1);
        end else begin
            arith_rs_head <= arith_rs_head;
        end
        if (allow_mem_dec) begin
            mem_rs_head <= mem_rs_head + ADDR_WIDTH'(1);
        end else begin
            mem_rs_head <= mem_rs_head;
        end
        if (allow_br_dec) begin
            br_rs_head <= br_rs_head + ADDR_WIDTH'(1);
        end else begin
            br_rs_head <= br_rs_head;
        end
        if (allow_mul_div_dec) begin
            mul_div_rs_head <= mul_div_rs_head + ADDR_WIDTH'(1);
        end else begin
            mul_div_rs_head <= mul_div_rs_head;
        end

        arith_count <= arith_count + arith_inc_count - arith_dec_count;
        mem_count <= mem_count + mem_inc_count - mem_dec_count;
        br_count <= br_count + br_inc_count - br_dec_count;
        mul_div_count <= mul_div_count + mul_div_inc_count - mul_div_dec_count;
    end
end

always_comb begin : count_logic
    if (allow_arith_inc) begin
        arith_inc_count = 1'b1;
    end else begin
        arith_inc_count = 1'b0;
    end
    if (allow_arith_dec) begin
        arith_dec_count = 1'b1;
    end else begin
        arith_dec_count = 1'b0;
    end

    if (allow_mem_inc) begin
        mem_inc_count = 1'b1;
    end else begin
        mem_inc_count = 1'b0;
    end
    if (allow_mem_dec) begin
        mem_dec_count = 1'b1;
    end else begin
        mem_dec_count = 1'b0;
    end

    if (allow_br_inc) begin
        br_inc_count = 1'b1;
    end else begin
        br_inc_count = 1'b0;
    end
    if (allow_br_dec) begin
        br_dec_count = 1'b1;
    end else begin
        br_dec_count = 1'b0;
    end

    if (allow_mul_div_inc) begin
        mul_div_inc_count = 1'b1;
    end else begin
        mul_div_inc_count = 1'b0;
    end
    if (allow_mul_div_dec) begin
        mul_div_dec_count = 1'b1;
    end else begin
        mul_div_dec_count = 1'b0;
    end
end

// TODO: Combinational logic to feed to the Functional Unit
/* PSUEDOCODE per FUs RS: 
    for each instr in reservation stations:
        if functional unit for RS is busy:
            do nothing
        else if instr uses rs1/rs2 and rs1/rs2 are ready
            send instr to the functional unit
        else 
            check for writebacks that match paddrs
*/
always_comb begin : feed_functional_units
    // ARITH
    if (!arith_fu_ready) begin
        arith_instr_pkt = '0; //dont care
        arith_instr_pkt_rdy = '0;
    end else if (arith_instr_ready) begin
        arith_instr_pkt = arith_rs[arith_rs_head].inst_pkt; //this will be gone next clock cycle
        arith_instr_pkt_rdy = '1;
    end else begin //we are going to need to check for wb updates
        arith_instr_pkt = '0;
        arith_instr_pkt_rdy = '0;
    end
    // MEM
    if (!mem_fu_ready) begin
        mem_instr_pkt = '0; 
        mem_instr_pkt_rdy = '0;
    end else if (mem_instr_ready) begin
        mem_instr_pkt = mem_rs[mem_rs_head];
        mem_instr_pkt_rdy = '1;
    end else begin
        mem_instr_pkt = '0;
        mem_instr_pkt_rdy = '0;
    end
    // br
    if (!br_fu_ready) begin
        br_instr_pkt = '0; 
        br_instr_pkt_rdy = '0;
    end else if (br_instr_ready) begin
        br_instr_pkt = br_rs[br_rs_head];
        br_instr_pkt_rdy = '1;
    end else begin
        br_instr_pkt = '0;
        br_instr_pkt_rdy = '0;
    end
    // mul_div
    if (!mul_div_fu_ready) begin
        mul_div_instr_pkt = '0;
        mul_div_instr_pkt_rdy = '0;
    end else if (mul_div_instr_ready) begin
        mul_div_instr_pkt = mul_div_rs[mul_div_rs_head];
        mul_div_instr_pkt_rdy = '1;
    end else begin
        mul_div_instr_pkt = '0;
        mul_div_instr_pkt_rdy = '0;
    end
end

// updates the values of the rs1 and rs2 registers if it should
always_ff @(posedge clk) begin
    for (integer i = 0; i < DEPTH; i++) begin
        if (bus_wb.valid
            && bus_wb.rd_paddr == arith_rs[i].inst_pkt.rs1_data[PHYS_REG_ADDR_WIDTH-1:0] //paddr comparison
            && arith_rs[i].inst_pkt.rs1_valid && !arith_rs[i].inst_pkt.rs1_ready) begin //rs1 used but not ready
            arith_rs[i].inst_pkt.rs1_data <= bus_wb.rd_data;
        end
        if (bus_wb.valid
            && bus_wb.rd_paddr == arith_rs[i].inst_pkt.rs2_data[PHYS_REG_ADDR_WIDTH-1:0] //paddr comparison
            && arith_rs[i].inst_pkt.rs2_valid && !arith_rs[i].inst_pkt.rs2_ready) begin //rs2 used but not ready
            arith_rs[i].inst_pkt.rs2_data <= bus_wb.rd_data;
        end

        if (bus_wb.valid
            && bus_wb.rd_paddr == mem_rs[i].inst_pkt.rs1_data[PHYS_REG_ADDR_WIDTH-1:0] //paddr comparison
            && mem_rs[i].inst_pkt.rs1_valid && !mem_rs[i].inst_pkt.rs1_ready) begin //rs1 used but not ready
            mem_rs[i].inst_pkt.rs1_data <= bus_wb.rd_data;
        end
        if (bus_wb.valid
            && bus_wb.rd_paddr == mem_rs[i].inst_pkt.rs2_data[PHYS_REG_ADDR_WIDTH-1:0] //paddr comparison
            && mem_rs[i].inst_pkt.rs2_valid && !mem_rs[i].inst_pkt.rs2_ready) begin //rs2 used but not ready
            mem_rs[i].inst_pkt.rs2_data <= bus_wb.rd_data;
        end

        if (bus_wb.valid
            && bus_wb.rd_paddr == br_rs[i].inst_pkt.rs1_data[PHYS_REG_ADDR_WIDTH-1:0] //paddr comparison
            && br_rs[i].inst_pkt.rs1_valid && !br_rs[i].inst_pkt.rs1_ready) begin //rs1 used but not ready
            br_rs[i].inst_pkt.rs1_data <= bus_wb.rd_data;
        end
        if (bus_wb.valid
            && bus_wb.rd_paddr == br_rs[i].inst_pkt.rs2_data[PHYS_REG_ADDR_WIDTH-1:0] //paddr comparison
            && br_rs[i].inst_pkt.rs2_valid && !br_rs[i].inst_pkt.rs2_ready) begin //rs2 used but not ready
            br_rs[i].inst_pkt.rs2_data <= bus_wb.rd_data;
        end

        if (bus_wb.valid
            && bus_wb.rd_paddr == mul_div_rs[i].inst_pkt.rs1_data[PHYS_REG_ADDR_WIDTH-1:0] //paddr comparison
            && mul_div_rs[i].inst_pkt.rs1_valid && !mul_div_rs[i].inst_pkt.rs1_ready) begin //rs1 used but not ready
            mul_div_rs[i].inst_pkt.rs1_data <= bus_wb.rd_data;
        end
        if (bus_wb.valid
            && bus_wb.rd_paddr == mul_div_rs[i].inst_pkt.rs2_data[PHYS_REG_ADDR_WIDTH-1:0] //paddr comparison
            && mul_div_rs[i].inst_pkt.rs2_valid && !mul_div_rs[i].inst_pkt.rs2_ready) begin //rs2 used but not ready
            mul_div_rs[i].inst_pkt.rs2_data <= bus_wb.rd_data;
        end
    end
end

// TODO: subject to change if we dont always want the head(oldest) of the RS fifo to be the next thing sent to the FU
always_comb begin : ready_for_issue_logic
    //ARITH
    arith_instr_ready = arith_rs[arith_rs_head].inst_pkt.rs1_ready && arith_rs[arith_rs_head].inst_pkt.rs2_ready;
    //MEM
    mem_instr_ready = mem_rs[mem_rs_head].inst_pkt.rs1_ready && mem_rs[mem_rs_head].inst_pkt.rs2_ready;
    //BR
    br_instr_ready = br_rs[br_rs_head].inst_pkt.rs1_ready && br_rs[br_rs_head].inst_pkt.rs2_ready;
    //MUL_DIV
    mul_div_instr_ready = mul_div_rs[mul_div_rs_head].inst_pkt.rs1_ready && mul_div_rs[mul_div_rs_head].inst_pkt.rs2_ready;
end

// TODO: Combinational logic to take from the Dispatch Stage

endmodule : reservation_stations
