`timescale 1ns / 1ps

module fwd_logic(RS2_EX_MEM, OP_Code_ID_EX, OP_Code_EX_Mem, EX_MEM_Rd, MEM__WB_Rd, Rs1, Rs2, Ex_MEM_Reg_E, MEM_WB_Reg_E, fwd_A, fwd_B, fwd_DMem);
input logic [4 : 0] EX_MEM_Rd, MEM__WB_Rd, Rs1, Rs2, RS2_EX_MEM;
input logic [6 : 0] OP_Code_ID_EX, OP_Code_EX_Mem;
input logic Ex_MEM_Reg_E, MEM_WB_Reg_E;
output logic [1 : 0] fwd_A, fwd_B;
output logic fwd_DMem;

always_comb begin 
    if(MEM_WB_Reg_E == 1 && (MEM__WB_Rd != 0) && (MEM__WB_Rd == RS2_EX_MEM) ) begin
        fwd_DMem = 1;
    end
    else begin
        fwd_DMem = 0;
    end

end


always_comb begin
        
    if(EX_MEM_Rd == Rs1 && Ex_MEM_Reg_E == 1 && EX_MEM_Rd != 0 && (OP_Code_ID_EX != 55 && OP_Code_ID_EX != 23))
        fwd_A = 2;
    else if(MEM_WB_Reg_E == 1 && (MEM__WB_Rd != 0) && !(Ex_MEM_Reg_E == 1 && (EX_MEM_Rd != 0)
            && (EX_MEM_Rd == Rs1)) && (MEM__WB_Rd == Rs1) && (OP_Code_EX_Mem != 99 && OP_Code_ID_EX != 55 && OP_Code_ID_EX != 23))
        fwd_A = 1;
    else 
        fwd_A = 0;
        
    if(EX_MEM_Rd == Rs2 && Ex_MEM_Reg_E == 1 && EX_MEM_Rd != 0 && (OP_Code_ID_EX == 51 && OP_Code_ID_EX != 23))
        fwd_B = 2;
    else if(MEM_WB_Reg_E == 1 && (MEM__WB_Rd != 0) && !(Ex_MEM_Reg_E == 1 && (EX_MEM_Rd != 0)
            && (EX_MEM_Rd == Rs2)) && (MEM__WB_Rd == Rs2) && (OP_Code_ID_EX != 19 && OP_Code_ID_EX != 55 && OP_Code_ID_EX != 23))
        fwd_B = 1;
    else 
        fwd_B  = 0;
   
end

endmodule
