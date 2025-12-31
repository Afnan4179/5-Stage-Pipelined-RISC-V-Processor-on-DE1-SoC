`timescale 1ns / 1ps

module Control_Unit_New(    // Changed name to match your Top.sv
    input logic [31:0] Inst,
    input logic BrLt, BrEq,
    output logic PC_Sel, 
    output logic [2:0] ImmSel, 
    output logic [2:0] Read_Write_Bytes, 
    output logic RegWEn, 
    output logic [1:0] Byte_Load_Store, 
    output logic BrUn, BSel, ASel, 
    output logic [3:0] ALUSel, 
    output logic MemWR, 
    output logic [1:0] WBSel
);

always_comb begin
    // --- STEP 1: SET DEFAULTS (Prevents "Latch" Errors) ---
    // If we don't set these here, the compiler thinks we want to 
    // "remember" the old value, which breaks always_comb.
    ALUSel = 4'd0;
    ASel = 0;
    BSel = 0;
    ImmSel = 3'd0;
    PC_Sel = 0;
    RegWEn = 0;
    BrUn = 0;
    MemWR = 0;
    WBSel = 0;
    Read_Write_Bytes = 3'd0;
    Byte_Load_Store = 2'd0;

    // --- STEP 2: OVERWRITE BASED ON INSTRUCTION ---
    case(Inst[6 : 2])
    5'b01100: begin       // R type
        if(Inst[14 : 12] == 3'h0 && Inst[30] == 0) begin
            ALUSel = 4'd0; // ADD
            RegWEn = 1;
            WBSel = 1;
        end
        else if(Inst[14 : 12] == 3'h0 && Inst[30] == 1) begin
            ALUSel = 4'd1; // SUB
            RegWEn = 1;
            WBSel = 1;
        end
        else if(Inst[14 : 12] == 3'h1 && Inst[30] == 0) begin
            ALUSel = 4'd2; // SLL
            RegWEn = 1;
            WBSel = 1;
        end
        else if(Inst[14 : 12] == 3'h2 && Inst[30] == 0) begin
            ALUSel = 4'd3; // SLT
            RegWEn = 1;
            WBSel = 1;
        end
        else if(Inst[14 : 12] == 3'h3 && Inst[30] == 0) begin
            ALUSel = 4'd4; // SLTU
            RegWEn = 1;
            WBSel = 1;
        end
        else if(Inst[14 : 12] == 3'h4 && Inst[30] == 0) begin
            ALUSel = 4'd5; // XOR
            RegWEn = 1;
            WBSel = 1;
        end
        else if(Inst[14 : 12] == 3'h5 && Inst[30] == 0) begin
            ALUSel = 4'd6; // SRL
            RegWEn = 1;
            WBSel = 1;
        end
        else if(Inst[14 : 12] == 3'h5 && Inst[30] == 1) begin
            ALUSel = 4'd7; // SRA
            RegWEn = 1;
            WBSel = 1;
        end
        else if(Inst[14 : 12] == 3'h6 && Inst[30] == 0) begin
            ALUSel = 4'd8; // OR
            RegWEn = 1;
            WBSel = 1;
        end
        else if(Inst[14 : 12] == 3'h7 && Inst[30] == 0) begin
            ALUSel = 4'd9; // AND
            RegWEn = 1;
            WBSel = 1;
        end
    end

    // I-Type (Arithmetic)
    5'b00100: begin
        RegWEn = 1;
        BSel = 1;
        WBSel = 1;
        // ImmSel defaults to 0 (3'b000) which is correct for I-Type
        
        if(Inst[14 : 12] == 0)      ALUSel = 4'd0; // ADDI
        else if(Inst[14 : 12] == 4) ALUSel = 4'd5; // XORI
        else if(Inst[14 : 12] == 6) ALUSel = 4'd8; // ORI
        else if(Inst[14 : 12] == 7) ALUSel = 4'd9; // ANDI
        else if(Inst[14 : 12] == 1) ALUSel = 4'd2; // SLLI
        else if(Inst[14 : 12] == 5 && Inst[30] == 0) ALUSel = 4'd6; // SRLI
        else if(Inst[14 : 12] == 5 && Inst[30] == 1) ALUSel = 4'd7; // SRAI
        else if(Inst[14 : 12] == 2) ALUSel = 4'd3; // SLTI
        else if(Inst[14 : 12] == 3) ALUSel = 4'd4; // SLTIU
    end

    // I-Type (Load)
    5'b00000: begin
        BSel = 1;
        ImmSel = 3'b001; // Load uses I-Type immediate logic but distinct encoding in your ImmGen?
                         // Assuming 3'b001 is correct based on your previous code
        RegWEn = 1;
        WBSel = 0;
        Read_Write_Bytes = Inst[14 : 12];
        
        // Note: Your original code had different settings for different loads,
        // but generally they all need ALUSel=ADD (0) to calculate address.
        ALUSel = 4'd0; 
        
        if(Inst[14:12] == 0 || Inst[14:12] == 1 || Inst[14:12] == 4 || Inst[14:12] == 5) begin
             Byte_Load_Store = Inst[21 : 20];
        end
        // For lw (2), defaults handle it
    end 

    // S-Type (Store)
    5'b01000: begin
        BSel = 1;
        ImmSel = 3'd2; // S-Type Immediate
        MemWR = 1;
        ALUSel = 4'd0; // ADD for address calc
        Read_Write_Bytes = Inst[14 : 12];
        
        if(Inst[14:12] == 0 || Inst[14:12] == 1) begin
             Byte_Load_Store = Inst[8 : 7];
        end
        // For sw (2), defaults handle it
    end

    // B-Type (Branch)
    5'b11000: begin
        ImmSel = 3'd3; // B-Type Immediate
        
        // Logic for taking the branch
        if ( (Inst[14:12] == 0 && BrEq) ||                  // BEQ
             (Inst[14:12] == 1 && !BrEq) ||                 // BNE
             (Inst[14:12] == 4 && BrLt) ||                  // BLT
             (Inst[14:12] == 5 && !BrLt) ||                 // BGE
             (Inst[14:12] == 6 && BrLt) ||                  // BLTU (Unsigned handled by BrUn output?)
             (Inst[14:12] == 7 && !BrLt) ) begin            // BGEU
            
            // Branch Taken
            ASel = 1;
            BSel = 1;
            PC_Sel = 1;
            ALUSel = 4'd0; // ADD PC + Imm
            WBSel = 2;     // Often branches don't write back, but keeping your logic
        end
        
        // Handle Unsigned Flag
        if (Inst[14:12] == 6 || Inst[14:12] == 7) BrUn = 1;
    end

    // JAL
    5'b11011: begin
        ASel = 1;
        BSel = 1;
        ImmSel = 3'd4; // J-Type
        PC_Sel = 1;
        RegWEn = 1;
        WBSel = 2;
        ALUSel = 4'd0; // ADD
    end

    // JALR
    5'b11001: begin
        if(Inst[14 : 12] == 0) begin
            ASel = 0;
            BSel = 1;
            ImmSel = 3'd0; // I-Type Imm
            PC_Sel = 1;
            RegWEn = 1;
            WBSel = 2;
            ALUSel = 4'd0; // ADD
        end
    end

    // LUI
    5'b01101: begin
        BSel = 1;
        ImmSel = 3'd5; // U-Type
        RegWEn = 1;
        WBSel = 1;
        ALUSel = 4'd10; // Specific LUI operation or handled by Imm?
    end

    // AUIPC
    5'b00101: begin
        ASel = 1;
        BSel = 1;
        ImmSel = 3'd5; // U-Type
        RegWEn = 1;
        WBSel = 1;
        ALUSel = 4'd11; // AUIPC op
    end
    
    endcase
end

endmodule