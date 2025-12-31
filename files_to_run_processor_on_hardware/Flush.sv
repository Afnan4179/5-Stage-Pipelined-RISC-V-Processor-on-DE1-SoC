`timescale 1ns / 1ps

module Flush(OP_Code_ID_EX, func3_ID_EX, BrEq, BrLt, flush);

input logic [6 : 0] OP_Code_ID_EX;
input logic [2 : 0] func3_ID_EX;
input logic BrEq, BrLt;
output logic flush;

always_comb begin
   if(OP_Code_ID_EX == 99) begin
        if((func3_ID_EX == 0) && (BrEq ==1))
            flush = 1;
        else if((func3_ID_EX == 1) && (BrEq == 0))
            flush = 1;
        else if((func3_ID_EX == 4) && (BrLt == 1))
            flush = 1;
        else if((func3_ID_EX == 5) && (BrLt == 0))
            flush = 1;
        else if((func3_ID_EX == 6) && (BrLt == 1))
            flush = 1;
        else if((func3_ID_EX == 7) && (BrLt == 0))
            flush = 1;
        else 
            flush = 0;
   end
   else if(OP_Code_ID_EX == 111)
            flush = 1;
   else if(OP_Code_ID_EX == 103)
            flush = 1;
   else
            flush = 0;
   
end


endmodule
