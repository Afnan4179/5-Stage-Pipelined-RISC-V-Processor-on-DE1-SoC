`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/16/2024 04:03:12 PM
// Design Name: 
// Module Name: branch_comp
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module branch_comp(inp1, inp2, BrUn, Eq, Lt);

input logic [31 : 0] inp1,inp2;
input logic BrUn;
output logic Eq, Lt;

always_comb begin
    if(BrUn == 1)
        begin
            if(inp1 < inp2) begin
                Lt = 1;
                Eq = 0;
            end
            else if(inp1 == inp2) begin 
                Eq = 1;
                Lt = 0;
            end
            else begin
                 Eq = 0;
                 Lt = 0;
            end            
        end
        
    else if (BrUn == 0) begin
        if($signed(inp1) < $signed(inp2)) begin
            Lt = 1;
            Eq = 0;
        end
        else if ($signed(inp1) == $signed(inp2)) begin
            Eq = 1;
            Lt = 0;
        end
        else begin
            Eq = 0;
            Lt = 0;
        end
    end 
end

endmodule
