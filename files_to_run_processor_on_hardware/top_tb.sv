`timescale 1ns / 1ps

module top_tb();
    logic clk, rst;

    // Clock generation: 10ns period (100MHz)
    always #5 clk = ~clk;

    Top dut(.clk(clk), .rst(rst));

    initial begin
        $dumpfile("dump.vcd"); 
        $dumpvars(0, top_tb);  
        
        clk = 0;
        rst = 1;
        #20 rst = 0;

        #1000; // Reduced time for faster simulation
        $finish();
    end

endmodule