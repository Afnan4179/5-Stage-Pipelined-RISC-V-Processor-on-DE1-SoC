`timescale 1ns / 1ps

module Branch_Selector(OP_Code_ID_EX, func3_ID_EX, BrEq, BrLt, ASel, BSel, PCSel, ALUSel, Asel_Branch, Bsel_Branch, PC_Sel_Branch, ALUSel_Branch);
input logic [6 : 0] OP_Code_ID_EX;
input logic [2 : 0] func3_ID_EX;
input logic BrEq, BrLt, ASel, BSel, PCSel;
input logic [3 : 0] ALUSel;
output logic Asel_Branch, Bsel_Branch, PC_Sel_Branch;
output logic [3 : 0] ALUSel_Branch;

always_comb begin
    if(OP_Code_ID_EX == 99) begin
        if((func3_ID_EX == 0) && (BrEq ==1)) begin
            Asel_Branch = 1;
            Bsel_Branch = 1;
            ALUSel_Branch = 0; 
            PC_Sel_Branch = 1;
            end
        else if((func3_ID_EX == 1) && (BrEq == 0)) begin
            Asel_Branch = 1;
            Bsel_Branch = 1;
            ALUSel_Branch = 0;
            PC_Sel_Branch = 1;
            end
        else if((func3_ID_EX == 4) && (BrLt == 1)) begin
            Asel_Branch = 1;
            Bsel_Branch = 1;
            ALUSel_Branch = 0;
            PC_Sel_Branch = 1;
            end
        else if((func3_ID_EX == 5) && (BrLt == 0)) begin
            Asel_Branch = 1;
            Bsel_Branch = 1;
            ALUSel_Branch = 0;
            PC_Sel_Branch = 1;
            end
        else if((func3_ID_EX == 6) && (BrLt == 1)) begin
            Asel_Branch = 1;
            Bsel_Branch = 1;
            ALUSel_Branch = 0;
            PC_Sel_Branch = 1;
            end
        else if((func3_ID_EX == 7) && (BrLt == 0)) begin
            Asel_Branch = 1;
            Bsel_Branch = 1;
            ALUSel_Branch = 0;
            PC_Sel_Branch = 1;
            end
        else  begin
            Asel_Branch = 0;
            Bsel_Branch = 0;
            ALUSel_Branch = 0;
            PC_Sel_Branch = 0;
            end
   end
   
   else begin
            Asel_Branch = ASel;
            Bsel_Branch = BSel;
            ALUSel_Branch = ALUSel;
            PC_Sel_Branch = PCSel;
            end

    end

endmodule
