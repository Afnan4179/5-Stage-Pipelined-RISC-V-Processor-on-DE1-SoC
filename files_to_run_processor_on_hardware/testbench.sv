`timescale 1ns / 1ps

module top_tb; // <--- You were likely missing this line

    // 1. Declare signals to connect to your Top module
    logic clk;
    logic rst;

    // 2. Instantiate the Top module (the CPU)
    Top dut (
        .clk(clk),
        .rst(rst)
    );

    // 3. Clock Generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns clock period
    end

    // 4. Stimulus and Waveform setup
    initial begin
        // These two lines are REQUIRED for the waveform viewer
        $dumpfile("dump.vcd");   
        $dumpvars(0, top_tb);    

        // Initialize Reset
        rst = 1;
        #20;
        rst = 0;

        // Run simulation for a set time
        #5000; 
        
        $display("Simulation Finished at %t", $time);
        $finish;
    end

endmodule // <--- And this line