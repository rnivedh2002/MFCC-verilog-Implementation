`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.05.2025 12:24:32
// Design Name: 
// Module Name: dct3
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


module dct3 (
    input wire clk, rst,
    input wire [7:0] log_mel_0, log_mel_1, log_mel_2,
    output reg [7:0] dct_out_0, dct_out_1, dct_out_2
);
    // Simplified DCT-II coefficients (Q1.7)
    wire [7:0] c0 = 8'd73; // sqrt(1/3) ≈ 0.577
    wire [7:0] c1 = 8'd90; // sqrt(2/3) * cos(pi/6) ≈ 0.707
    wire [7:0] c2 = 8'd45; // sqrt(2/3) * cos(pi/3) ≈ 0.354

    // Multiply log_mel values with coefficients (16-bit intermediate)
    wire signed [15:0] sum_0 = log_mel_0 * c0 + log_mel_1 * c0 + log_mel_2 * c0;
    wire signed [15:0] sum_1 = log_mel_0 * c1 - log_mel_2 * c1;
    wire signed [15:0] sum_2 = log_mel_0 * c2 - log_mel_2 * c2;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            dct_out_0 <= 8'd0;
            dct_out_1 <= 8'd0;
            dct_out_2 <= 8'd0;
        end else begin
            dct_out_0 <= sum_0[15:8]; // Q1.7 scaled output
            dct_out_1 <= sum_1[15:8];
            dct_out_2 <= sum_2[15:8];
        end
    end
endmodule
