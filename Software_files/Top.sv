`timescale 1ns / 1ps

// --- HELPER MODULES ---
module adder (
    input  logic [31:0] PC_Out,
    output logic [31:0] PC_Plus_4
);
    assign PC_Plus_4 = PC_Out + 4;
endmodule

module mux (
    input  logic [31:0] inp0, inp1,
    input  logic sel,
    output logic [31:0] PC_in
);
    always_comb begin
        PC_in = (sel) ? inp1 : inp0;
    end
endmodule

// --- MAIN TOP MODULE ---
module Top(input logic clk, rst);
    
    // Signal Declarations
    logic [31:0] PC_in, PC_Out, Inst, dataW, dataR1, dataR2, ALU_Inp1, ALU_Inp2, Imm_Value;
    logic [31:0] ALU_Out, DataB, PC_Plus_4, DMem_Inp;
    logic BrEq, BrLt, IF_ID_Reg_Write_Enable, PC_Write, ID_EX_Mux_Sel, fwd_DMem_MUX_Sel, flush, Asel_Branch, Bsel_Branch, PC_Sel_Branch;
    
    // --- CONTROL SIGNALS ---
    // Update: Imm_Sel is now 3 bits to match Control_Unit
    logic [2:0] Imm_Sel;       
    logic [3:0] ALUSel_Branch; 
    logic [1:0] Forward_A, Forward_B;
    
    // Pipeline Register Buses
    logic [63:0] Fetch_Decode_Out;
    logic [176:0] Decode_Execute_In, Decode_Execute_Out;
    logic [129:0] Execute_Mem_In, Execute_Mem_Out;
    logic [109:0] Mem_WB_In, Mem_WB_Out;

    // Internal wires
    logic [31:0] Mux_M1_Out, Mux_M2_Out;

    // --- FETCH STAGE ---
    Program_Counter PC(PC_in, clk, rst, PC_Write, PC_Out);
    inst_mem IMem(PC_Out, Inst);
    adder PC_Adder(PC_Out, PC_Plus_4); 
    mux MUX_PC(PC_Plus_4, ALU_Out, PC_Sel_Branch, PC_in);
    
    // Note: IF_ID_Reg_Write_Enable acts as a Stall (Active High in your Hazard Unit), 
    // so it connects to Write_Enable (Active Low logic in pipe_reg_with_low).
    pipe_reg_with_low #(.Width(64)) reg_Fetch(
        .clk(clk), .rst(rst), 
        .Write_Enable(IF_ID_Reg_Write_Enable), .flush(flush), 
        .inp({PC_Out, Inst}), .out(Fetch_Decode_Out)
    );

    // FIX: Named Mapping using your hazard_detection.sv port names
    hazard_detection Hazard_Detect(
        .clk(clk), 
        .OP_Code_IF_ID(Fetch_Decode_Out[6:0]), 
        .OP_Code_ID_EX(Decode_Execute_Out[173:167]), 
        .ID_EX_Rd(Decode_Execute_Out[132:128]), 
        .IF_ID_Rs1(Fetch_Decode_Out[19:15]), 
        .IF_ID_Rs2(Fetch_Decode_Out[24:20]), 
        .IF_ID_Write(IF_ID_Reg_Write_Enable), // Output from Hazard
        .PC_Write(PC_Write),                  // Output from Hazard
        .Mux_i(ID_EX_Mux_Sel)                 // Output from Hazard
    );

    // --- DECODE STAGE ---
    Reg_file RF(
        .clk(clk), .rst(rst), 
        .Register_E(Mem_WB_Out[101]), 
        .rsW(Mem_WB_Out[100:96]), 
        .rs1(Fetch_Decode_Out[19:15]), 
        .rs2(Fetch_Decode_Out[24:20]), 
        .dataW(dataW), 
        .data1(dataR1), .data2(dataR2)
    );

    // NOTE: Ensure your imm_gen module expects a 3-bit Imm_Sel now
    imm_gen IM_Gen(Fetch_Decode_Out[31:0], Imm_Sel, Imm_Value);
    
    // Control Signal Wires
    logic [3:0] ctrl_ALUSel;
    logic [2:0] ctrl_RW_Bytes;
    logic [1:0] ctrl_WB_Sel, ctrl_LdSt;
    logic ctrl_RegEn, ctrl_PCSel, ctrl_BrUn, ctrl_BSel, ctrl_ASel, ctrl_MemW;

    // FIX: Named Mapping using your Control_Unit.sv port names
    Control_Unit CU(
        .Inst(Fetch_Decode_Out[31:0]), 
        .BrEq(BrEq), 
        .BrLt(BrLt), 
        .PC_Sel(ctrl_PCSel), 
        .ImmSel(Imm_Sel), 
        .Read_Write_Bytes(ctrl_RW_Bytes),
        .RegWEn(ctrl_RegEn), 
        .Byte_Load_Store(ctrl_LdSt), 
        .BrUn(ctrl_BrUn), 
        .BSel(ctrl_BSel), 
        .ASel(ctrl_ASel), 
        .ALUSel(ctrl_ALUSel), 
        .MemWR(ctrl_MemW), 
        .WBSel(ctrl_WB_Sel)
    );
                 
    // Fixed concatenation: Ensure total bits = 177
    assign Decode_Execute_In = {Fetch_Decode_Out[14:12], Fetch_Decode_Out[6:0], Fetch_Decode_Out[24:15], Fetch_Decode_Out[11:7], BrEq, BrLt, ctrl_PCSel, ctrl_RW_Bytes, 
                                ctrl_RegEn, ctrl_LdSt, ctrl_BrUn, ctrl_BSel, ctrl_ASel, ctrl_ALUSel, ctrl_MemW, ctrl_WB_Sel, Fetch_Decode_Out[11:7], 
                                Fetch_Decode_Out[63:32], dataR1, dataR2, Imm_Value}; 
    
    pipe_reg_with_flush #(.Width(177)) reg_Decode(
        .flush(flush), .clk(clk), .rst(rst),
        .inp(Decode_Execute_In), .out(Decode_Execute_Out)
    );

    // --- EXECUTE STAGE ---
    mux2x1 M1(Decode_Execute_Out[95:64], Decode_Execute_Out[127:96], Asel_Branch, Mux_M1_Out);
    mux2x1 M2(Decode_Execute_Out[63:32], Decode_Execute_Out[31:0], Bsel_Branch, Mux_M2_Out);
    
    Branch_Selector BS(
        Decode_Execute_Out[173:167], Decode_Execute_Out[176:174], BrEq, BrLt,
        Decode_Execute_Out[140], Decode_Execute_Out[141], Decode_Execute_Out[149], Decode_Execute_Out[139:136],
        Asel_Branch, Bsel_Branch, PC_Sel_Branch, ALUSel_Branch
    );

    mux_4x1 Fwd_Mux_A(Mux_M1_Out, dataW, Execute_Mem_Out[63:32], Forward_A, ALU_Inp1);
    mux_4x1 Fwd_Mux_B(Mux_M2_Out, dataW, Execute_Mem_Out[63:32], Forward_B, ALU_Inp2);

    alu_logic ALU(ALUSel_Branch, ALU_Inp1, ALU_Inp2, ALU_Out);
    
    // Fixed concatenation: Ensure total bits = 130
    assign Execute_Mem_In = {Decode_Execute_Out[166:162], Decode_Execute_Out[173:167], Decode_Execute_Out[156:152], Decode_Execute_Out[151:143], Decode_Execute_Out[135], Decode_Execute_Out[134:133], 
                             Decode_Execute_Out[132:128], ALU_Inp2, ALU_Out, Decode_Execute_Out[127:96]}; 
    
    pipe_reg #(.Width(130)) reg_Execute(
        .clk(clk), .rst(rst),
        .inp(Execute_Mem_In), .out(Execute_Mem_Out)
    );

    // --- FORWARDING LOGIC ---
    fwd_logic Forward_Logic(
        Execute_Mem_Out[129:125], Decode_Execute_Out[173:167], Execute_Mem_Out[124:118], Execute_Mem_Out[117:113], Mem_WB_Out[108:104],
        Decode_Execute_Out[161:157], Decode_Execute_Out[166:162], 
        Execute_Mem_Out[106], Mem_WB_Out[101], Forward_A, Forward_B, fwd_DMem_MUX_Sel
    );

    // --- MEMORY STAGE ---
    mux2x1 Mux_to_DMem(Execute_Mem_Out[95:64], dataW, fwd_DMem_MUX_Sel, DMem_Inp);
    
    DMEM Data_Mem(
        Execute_Mem_Out[63:32], DMem_Inp, Execute_Mem_Out[103], clk, rst,
        Execute_Mem_Out[109:107], Execute_Mem_Out[105:104], DataB
    );
    
    // Fixed: Ensure Mem_WB_In is exactly 110 bits
    assign Mem_WB_In = {Execute_Mem_Out[103], Execute_Mem_Out[117:113], Execute_Mem_Out[102:101], Execute_Mem_Out[106], Execute_Mem_Out[100:96],
                        32'b0, Execute_Mem_Out[63:32], DataB};
    
    pipe_reg #(.Width(110)) Mem_reg(
        .clk(clk), .rst(rst),
        .inp(Mem_WB_In), .out(Mem_WB_Out)
    );

    // --- WRITE BACK STAGE ---
    mux_4x1 M3(Mem_WB_Out[31:0], Mem_WB_Out[63:32], Mem_WB_Out[95:64], Mem_WB_Out[103:102], dataW);

endmodule