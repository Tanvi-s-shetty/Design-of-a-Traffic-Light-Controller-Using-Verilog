`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.10.2026 18:47:57
// Design Name: 
// Module Name: traffic_light
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




module traffic_light_controller (
    input clk,
    input reset,
    output reg [1:0] NS_light,
    output reg [1:0] EW_light
);

    // Define states for FSM
    parameter NS_GREEN_EW_RED  = 2'b00;
    parameter NS_YELLOW_EW_RED = 2'b01;
    parameter NS_RED_EW_GREEN  = 2'b10;
    parameter NS_RED_EW_YELLOW = 2'b11;

    reg [1:0] state, next_state;

    // State transitions on clock
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= NS_GREEN_EW_RED;
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        next_state = NS_GREEN_EW_RED;

        case (state)
            NS_GREEN_EW_RED:
                next_state = NS_YELLOW_EW_RED;

            NS_YELLOW_EW_RED:
                next_state = NS_RED_EW_GREEN;

            NS_RED_EW_GREEN:
                next_state = NS_RED_EW_YELLOW;

            NS_RED_EW_YELLOW:
                next_state = NS_GREEN_EW_RED;

            default:
                next_state = NS_GREEN_EW_RED;
        endcase
    end

    // Output logic
    always @(*) begin
        NS_light = 2'b00;
        EW_light = 2'b00;

        case (state)
            NS_GREEN_EW_RED: begin
                NS_light = 2'b10;
                EW_light = 2'b00;
            end

            NS_YELLOW_EW_RED: begin
                NS_light = 2'b01;
                EW_light = 2'b00;
            end

            NS_RED_EW_GREEN: begin
                NS_light = 2'b00;
                EW_light = 2'b10;
            end

            NS_RED_EW_YELLOW: begin
                NS_light = 2'b00;
                EW_light = 2'b01;
            end

            default: begin
                NS_light = 2'b00;
                EW_light = 2'b00;
            end
        endcase
    end

endmodule

