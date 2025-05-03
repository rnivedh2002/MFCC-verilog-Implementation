`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.05.2025 12:23:36
// Design Name: 
// Module Name: mel_filter_bank
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


module mel_filter_bank (
    input wire clk, rst,
    input wire signed [7:0] fft_real_0, fft_real_1, fft_real_2, fft_real_3,
    input wire signed [7:0] fft_real_4, fft_real_5, fft_real_6, fft_real_7,
    input wire signed [7:0] fft_imag_0, fft_imag_1, fft_imag_2, fft_imag_3,
    input wire signed [7:0] fft_imag_4, fft_imag_5, fft_imag_6, fft_imag_7,
    output reg [7:0] mel_out_0, mel_out_1, mel_out_2
);
    // Power spectrum
    wire [15:0] power_0 = (fft_real_0 * fft_real_0) + (fft_imag_0 * fft_imag_0);
    wire [15:0] power_1 = (fft_real_1 * fft_real_1) + (fft_imag_1 * fft_imag_1);
    wire [15:0] power_2 = (fft_real_2 * fft_real_2) + (fft_imag_2 * fft_imag_2);
    wire [15:0] power_3 = (fft_real_3 * fft_real_3) + (fft_imag_3 * fft_imag_3);
    wire [15:0] power_4 = (fft_real_4 * fft_real_4) + (fft_imag_4 * fft_imag_4);
    wire [15:0] power_5 = (fft_real_5 * fft_real_5) + (fft_imag_5 * fft_imag_5);
    wire [15:0] power_6 = (fft_real_6 * fft_real_6) + (fft_imag_6 * fft_imag_6);
    wire [15:0] power_7 = (fft_real_7 * fft_real_7) + (fft_imag_7 * fft_imag_7);

    
    reg [7:0] weights [0:2][0:7];
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            weights[0][0] <= 8'd127; weights[0][1] <= 8'd127; weights[0][2] <= 8'd127; weights[0][3] <= 8'd0;
            weights[0][4] <= 8'd0;   weights[0][5] <= 8'd0;   weights[0][6] <= 8'd0;   weights[0][7] <= 8'd0;
            weights[1][0] <= 8'd127; weights[1][1] <= 8'd127; weights[1][2] <= 8'd127; weights[1][3] <= 8'd127;
            weights[1][4] <= 8'd127; weights[1][5] <= 8'd0;   weights[1][6] <= 8'd0;   weights[1][7] <= 8'd0;
            weights[2][0] <= 8'd0;   weights[2][1] <= 8'd0;   weights[2][2] <= 8'd0;   weights[2][3] <= 8'd0;
            weights[2][4] <= 8'd0;   weights[2][5] <= 8'd127; weights[2][6] <= 8'd127; weights[2][7] <= 8'd127;
        end
    end

    // Mel filter application
    wire [23:0] mel_temp_0 = (power_0 * weights[0][0]) + (power_1 * weights[0][1]) + (power_2 * weights[0][2]);
    wire [23:0] mel_temp_1 = (power_0 * weights[1][0]) + (power_1 * weights[1][1]) + (power_2 * weights[1][2]) + 
                             (power_3 * weights[1][3]) + (power_4 * weights[1][4]);
    wire [23:0] mel_temp_2 = (power_5 * weights[2][5]) + (power_6 * weights[2][6]) + (power_7 * weights[2][7]);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            mel_out_0 <= 8'd0;
            mel_out_1 <= 8'd0;
            mel_out_2 <= 8'd0;
        end else begin
            mel_out_0 <= mel_temp_0[17:10];
            mel_out_1 <= mel_temp_1[17:10];
            mel_out_2 <= mel_temp_2[17:10];
        end
    end
endmodule
