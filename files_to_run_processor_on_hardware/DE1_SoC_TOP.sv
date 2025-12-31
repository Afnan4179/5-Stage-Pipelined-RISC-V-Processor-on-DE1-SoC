module DE1_SoC_TOP(
    input  logic        CLOCK_50, // 50MHz Clock
    input  logic [3:0]  KEY,      // Buttons (Active Low)
    output logic [9:0]  LEDR,     // Red LEDs
    output logic [6:0]  HEX0,     // Right-most 7-segment
    output logic [6:0]  HEX1      // Second 7-segment
);

    logic [31:0] cpu_result;
    logic [25:0] count;
    logic slow_clk;

    // --- Clock Divider ---
    // Slow down the 50MHz clock to visible speed (~1.5 Hz)
    always_ff @(posedge CLOCK_50) begin
        count <= count + 1;
    end
    assign slow_clk = count[24]; 

    // --- Instantiate the Processor ---
    Top CPU_Instance (
        .clk(slow_clk), 
        .rst(~KEY[0]), // KEY0 is reset (Invert because keys are 0 when pressed)
        .ALU_Result(cpu_result)
    );

    // --- Output to LEDs (Binary) ---
    assign LEDR = cpu_result[9:0];

    // --- Output to 7-Segment (Hexadecimal) ---
    SevenSeg digit0 (.bin(cpu_result[3:0]), .seg(HEX0));
    SevenSeg digit1 (.bin(cpu_result[7:4]), .seg(HEX1));

endmodule