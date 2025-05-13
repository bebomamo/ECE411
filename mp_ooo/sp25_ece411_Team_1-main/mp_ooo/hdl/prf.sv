module prf
import rv32i_types::*;
(
    input logic                                 rst,
    input logic                                 clk,
    input logic					branch_miss,

    //Dispatch State
    input logic [PHYS_REG_ADDR_WIDTH-1:0]       rs1_paddr,      
    output prf_t                                rs1_entry,      // {valid, data}

    input logic [PHYS_REG_ADDR_WIDTH-1:0]       rs2_paddr,
    output prf_t                                rs2_entry,      // {valid, data}

    //Writeback Stage
    input   logic       [PHYS_REG_ADDR_WIDTH-1:0]           wb_rd_paddr,    // Destination Address from writeback                 
    input   logic       [31:0]                              wb_data,        // CDB from writeback
    input   logic                                           wb_web,

    // Commit stage     
    input logic [PHYS_REG_ADDR_WIDTH-1:0]   commit_paddr,       // address to read data from to port to ARF
    output rat_arf_t                        commit_entry,     // data to send to ARF
    //input logic                             commit_prf_web,      // used to update valid {1 -> 0}
    input logic                             commit_addr_stay_renamed,
    input logic retire_prf_web,
    input logic [PHYS_REG_ADDR_WIDTH-1:0] retire_prf_paddr
    
);

    logic [4:0]  csb; //one (b)it per port
    logic [4:0]  valid_web;
    logic [4:0]  data_web;
    logic [PHYS_REG_ADDR_WIDTH-1:0]  addr [5]; //RV32 architectural register addr select per port

    logic valid_i_in  [5];
    logic valid_i_out [5];
    logic [31:0] data_i_in  [5];
    logic [31:0] data_i_out [5];

    logic read_retire_edge;

    assign csb = '0;        // Easier use if always on, can modify to try and save power maybe 

    param_ff_array #(.NUM_PORTS(5), .S_INDEX(PHYS_REG_ADDR_WIDTH), .WIDTH(1), .PORT_FORWARD(1)) valid_i (
        .clk(clk),         
        .rst(rst | branch_miss),        
        .csb(csb),      
        .web(valid_web),     
        .addr(addr),
        .din(valid_i_in),
        .dout(valid_i_out)
    );

    param_ff_array #(.NUM_PORTS(5), .S_INDEX(PHYS_REG_ADDR_WIDTH), .WIDTH(32), .PORT_FORWARD(1)) data_i (
        .clk(clk),         
        .rst(rst),        
        .csb(csb),      
        .web(data_web),     
        .addr(addr),
        .din(data_i_in),
        .dout(data_i_out)
    );



    always_comb begin : PRF_Logic
        // Defaults 
        addr[0] = rs1_paddr;        // For dispatch to check PRF
        addr[1] = rs2_paddr;        // For dispatch to check PRF
        addr[2] = wb_rd_paddr;      // CDB write to PRF
        addr[3] = commit_paddr;     // Read data to rrf for retiring
        addr[4] = retire_prf_paddr;    // Write valid (b)it low, ARF has a copy

        valid_web = '1;
        data_web = '1;


        rs1_entry.valid = valid_i_out[0];
        rs1_entry.data = data_i_out[0];
            
        rs2_entry.valid = valid_i_out[1];
        rs2_entry.data = data_i_out[1];

        //commit entry values
        commit_entry.data = data_i_out[3];
        commit_entry.valid = '1;
        commit_entry.renamed = commit_addr_stay_renamed;
        commit_entry.paddr = 'x;

        data_i_in[0] = '0;
        data_i_in[1] = '0;
        data_i_in[2] = wb_data;
        data_i_in[3] = '0;
        data_i_in[4] = '0;

        // valid inputs
        valid_i_in[0] = '0;
        valid_i_in[1] = '0;
        valid_i_in[2] = '1;     // Write 1 on PRF indicating ready
        valid_i_in[3] = '0;     // TODO may be problematic, but should be valid if commiting
        valid_i_in[4] = '0;     // Disvalidate register

        // Break apart stage write enbables to corresponding submodules
        if (wb_web) begin
            valid_web[2] = '0;
            data_web[2] = '0;
        end

        if (retire_prf_web)
            valid_web[4] = '0;


    end



endmodule
