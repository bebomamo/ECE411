module rat_arf
import rv32i_types::*;
(
    input   logic       clk,
    input   logic       rst,
    input   logic       branch_miss,

    // Rename Stage
    input   logic       [4:0]               rename_rd_addr,     // Destination address that needs mapping
    input   rat_arf_t                       rename_entry,       // {X, renamed, paddr, X}
    input   logic                           rename_web,         // Need to enable correct sub-arrays (non-X entry arrays)

    input   logic       [4:0]               rs1_addr,           // Source Register 1 Address to read from            
    output  rat_arf_t                       rs1_entry,          // {valid, renamed->1, paddr, data} 

    input   logic       [4:0]               rs2_addr,           // Source Register 2 Address to read from        
    output  rat_arf_t                       rs2_entry,

    // Commit Stage
    input   logic       [4:0]               commit_rd_addr,     // Destination Address to unmap                 
    input   rat_arf_t                       commit_entry,       // {valid->1, renamed->0, X,  data}
    input   logic                           commit_web,         // Need to enable correct sub-arrays (non-X entry arrays)          

    // Retire Stage
    output rat_arf_t                        rat_entry_to_update, // Check renamed status and paddr for retire stage, determines if renamed status will change
    input  logic [4:0]                      head_entry_rd_addr
);

// DP arrays for storing RAT + ARF - {valid, renamed, paddr, arch_data}
// renamed 0 - use ARF, 1- use PRF
// valid 0 - unkown data until first write, 1 - known data at all times

// csb, web, and addr will be combinationally determined via rs's, rd's, and opcodes from rename and commit stages
logic [4:0]  csb; //one (b)it per port
logic [4:0] valid_web;
logic [4:0] renamed_web;
logic [4:0] paddr_web;
logic [4:0] data_web;
logic [4:0]  addr [5]; //RV32 architectural register addr select per port

// combinationally determined per port data in and out
logic valid_i_in  [5];
logic valid_i_out [5];
logic renamed_i_in  [5];
logic renamed_i_out [5];
logic [PHYS_REG_ADDR_WIDTH-1:0] paddr_i_in  [5];
logic [PHYS_REG_ADDR_WIDTH-1:0] paddr_i_out [5];
logic [31:0] data_i_in  [5];
logic [31:0] data_i_out [5];


assign csb = '0;        // Easier use if always on, can modify to try and save power maybe 


// 2 reads (source regs), 1 write (dest reg)
param_ff_array #(.NUM_PORTS(5), .S_INDEX(5), .WIDTH(1)) valid_i (
    .clk(clk),         
    .rst(rst),        
    .csb(csb),      
    .web(valid_web),     
    .addr(addr),
    .din(valid_i_in),
    .dout(valid_i_out)
);

// 2 reads (source regs), 1 write (dest reg)
// Rename stage will change a arch addr renamed value to 1 for new mapping, will need to be read for source registers 
// Commit stage will change a arch addr renamed value to 0 to remove mapping
param_ff_array #(.NUM_PORTS(5), .S_INDEX(5), .WIDTH(1)) renamed_i (
    .clk(clk),         
    .rst(rst | branch_miss),        
    .csb(csb),      
    .web(renamed_web),     
    .addr(addr),
    .din(renamed_i_in),
    .dout(renamed_i_out)
);

// 2 reads (source regs), 1 write (dest reg)
// Rename stage will change paddr to value from free list, will also need to read for source registers
// Commit stage does nothing (since renamed will go to 0)
param_ff_array #(.NUM_PORTS(5), .S_INDEX(5), .WIDTH(PHYS_REG_ADDR_WIDTH)) paddr_i (
    .clk(clk),         
    .rst(rst),        
    .csb(csb),      
    .web(paddr_web),     
    .addr(addr),
    .din(paddr_i_in),
    .dout(paddr_i_out)
);

// 2 reads (source regs), 1 write (dest reg)
// Rename wont modify but will read from 2 ports
// Commit will write with 1 port to update 1 arch value (the one being committed)
param_ff_array #(.NUM_PORTS(5), .S_INDEX(5), .WIDTH(32)) data_i (
    .clk(clk),         
    .rst(rst),        
    .csb(csb),      
    .web(data_web),     
    .addr(addr),
    .din(data_i_in),
    .dout(data_i_out)
);

// TODO add logic to enable correct web's and satisfy rename and commit stage
// accesses
// indices 0 and 1 are for reading source registers that may be available via ARF
// index 2 is for writing a paddr and renaming the rd of the instr in rename
// index 3 is for writing back to ARF from commit
// index 4 is for reading from head_entry.rd_addr to compare with retiring rd_addr to see if the rd_addr is still renamed
always_comb begin : RAT_Logic
    // Defaults 
    addr[0] = rs1_addr;
    addr[1] = rs2_addr;
    addr[2] = rename_rd_addr;
    addr[3] = commit_rd_addr;
    addr[4] = head_entry_rd_addr;
    valid_web = '1;
    renamed_web = '1;
    paddr_web = '1;
    data_web = '1;

    // rs output entries
    rs1_entry.valid = valid_i_out[0];
    rs1_entry.renamed = renamed_i_out[0];
    rs1_entry.paddr = paddr_i_out[0];
    rs1_entry.data = data_i_out[0];
        
    rs2_entry.valid = valid_i_out[1];
    rs2_entry.renamed = renamed_i_out[1];
    rs2_entry.paddr = paddr_i_out[1];
    rs2_entry.data = data_i_out[1];

    // get the output paddr from the head_entry_rd_addr
    rat_entry_to_update.renamed = renamed_i_out[4];
    rat_entry_to_update.paddr = paddr_i_out[4];

    // renaming rd_addr from index 2 to a specified paddr
    renamed_i_in[0] = '0;
    renamed_i_in[1] = '0;
    renamed_i_in[2] = rename_entry.renamed;
    renamed_i_in[3] = commit_entry.renamed;
    renamed_i_in[4] = '0;

    paddr_i_in[0] = '0; // should be irrelevant based on web    
    paddr_i_in[1] = '0;
    paddr_i_in[2] = rename_entry.paddr;
    paddr_i_in[3] = '0;
    paddr_i_in[4] = '0;

    // committing data from index 3
    data_i_in[0] = '0;
    data_i_in[1] = '0;
    data_i_in[2] = '0;
    data_i_in[3] = commit_entry.data;
    data_i_in[4] = '0;

    // valid inputs
    valid_i_in[0] = '0;
    valid_i_in[1] = '0;
    valid_i_in[2] = '0;
    valid_i_in[3] = commit_entry.valid;
    valid_i_in[4] = '0;

    // Break apart stage write enbables to corresponding submodules
    if (!rename_web) begin
        renamed_web[2] = '0;
        paddr_web[2] = '0;
    end
    if (!commit_web) begin
        valid_web[3] = '0;
        renamed_web[3] = (!rename_web && (addr[2] == addr[3])) ? '1 : '0;
        data_web[3] = '0;
    end
end

endmodule : rat_arf
