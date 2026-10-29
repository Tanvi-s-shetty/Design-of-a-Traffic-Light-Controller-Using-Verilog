`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.10.2026 19:22:20
// Design Name: 
// Module Name: traffic_light_tb
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



module tb_traffic_light;

    reg clk;
    reg reset;

    wire [1:0] NS_light;
    wire [1:0] EW_light;

    // Instantiate the traffic light controller
    traffic_light_controller uut (
        .clk(clk),
        .reset(reset),
        .NS_light(NS_light),
        .EW_light(EW_light)
    );

    // Clock generation: 10ns period
    always begin
        #5 clk = ~clk;
    end

    // Test sequence
    initial begin
        clk = 0;
        reset = 1;

        #10 reset = 0;

        // Run simulation for 100ns
        #100 $finish;
    end

    // Monitor output signals
    initial begin
        $monitor(
            "At time %0t, NS_light = %b, EW_light = %b",
            $time, NS_light, EW_light
        );
    end

endmodule
