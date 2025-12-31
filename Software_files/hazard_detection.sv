`timescale 1ns / 1ps

module hazard_detection(clk, OP_Code_IF_ID, OP_Code_ID_EX, ID_EX_Rd, IF_ID_Rs1, IF_ID_Rs2, IF_ID_Write, PC_Write, Mux_i);
input logic [4 : 0] ID_EX_Rd, IF_ID_Rs1, IF_ID_Rs2;
input logic [6 : 0] OP_Code_ID_EX, OP_Code_IF_ID;
input logic clk;
output logic IF_ID_Write, PC_Write, Mux_i;


always_comb begin
    if(((ID_EX_Rd == IF_ID_Rs1) || (ID_EX_Rd == IF_ID_Rs2)) && OP_Code_ID_EX == 7'd3
        && (IF_ID_Rs1 != 0) && (IF_ID_Rs2 != 0) && (OP_Code_IF_ID != 35))
   begin
        Mux_i = 0;
        IF_ID_Write = 1;
        PC_Write = 0; 
    end
    else begin
        Mux_i = 1;
        IF_ID_Write = 0;
        PC_Write = 1;
    end
    
end


always_comb begin
    

end


endmodule
