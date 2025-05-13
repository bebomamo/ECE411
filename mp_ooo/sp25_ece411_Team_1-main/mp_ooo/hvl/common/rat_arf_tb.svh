import rv32i_types::*;

logic       [4:0]               rename_rd_addr;
logic       [PHYS_REG_ADDR_WIDTH:0]  rename_paddr;
rat_arf_t                       rename_entry;
logic                           rename_web; 
logic       [4:0]               rs1_addr;   
rat_arf_t                       rs1_entry;   
logic       [4:0]               rs2_addr;      
rat_arf_t                       rs2_entry;
logic       [4:0]               commit_rd_addr;           
rat_arf_t                       commit_entry;
logic                           commit_web;

rat_arf dut (.*);

// Test Sequence
initial begin
    // Initialize
    clk = '0;
    rst = '1;
    @(posedge clk); 
    rst = '0; // Deassert reset
    @(posedge clk); 
    commit_rd_addr = '0;
    commit_web = '0;

    rs1_addr = '0;
    rs2_addr = '0;
    $display("Renaming all RAT entries to same PA");
    for (int i=0; i<32; i++) begin
        rename_rd_addr = i[4:0];
        rename_entry.renamed = 1'b1;
        rename_entry.paddr = i[PHYS_REG_ADDR_WIDTH-1:0]+1'b1;
        rename_web = 1'b1;
        @(posedge clk);
    end
    rename_web = 1'b0;
    $display("Test rename and paddr values from RAT");
    for (int i=0; i<16; i++) begin
        rs1_addr = i[4:0];
        @(posedge clk)
        @(posedge clk)
        $display("[RS1] Addr: %d | valid:%h | renamed: %h | paddr: %h | data: %h", rs1_addr, rs1_entry.valid, rs1_entry.renamed, rs1_entry.paddr, rs1_entry.data);
        @(posedge clk);
    end

    for (int i=16; i<32; i++) begin
        rs2_addr = i[4:0];
        @(posedge clk)
        @(posedge clk)
        $display("[RS2] Addr: %d | valid:%h | renamed: %h | paddr: %h | data: %h", rs2_addr, rs2_entry.valid, rs2_entry.renamed, rs2_entry.paddr, rs2_entry.data);
        @(posedge clk);
    end
    for (int i=2; i<32; i+=2) begin
        commit_rd_addr = i[4:0];
        commit_entry.valid = 1'b1;
        commit_entry.renamed = 1'b0;
        commit_web = 1'b1;
        @(posedge clk);
    end

    $display("Test commit values from RAT");
    for (int i=0; i<16; i++) begin
        rs1_addr = i[4:0];
        @(posedge clk)
        @(posedge clk)
        $display("[RS1] Addr: %d | valid:%h | renamed: %h | paddr: %h | data: %h", rs1_addr, rs1_entry.valid, rs1_entry.renamed, rs1_entry.paddr, rs1_entry.data);
        @(posedge clk);
    end

    for (int i=16; i<32; i++) begin
        rs2_addr = i[4:0];
        @(posedge clk)
        @(posedge clk)
        $display("[RS2] Addr: %d | valid:%h | renamed: %h | paddr: %h | data: %h", rs2_addr, rs2_entry.valid, rs2_entry.renamed, rs2_entry.paddr, rs2_entry.data);
        @(posedge clk);
    end

    $finish;
end


