`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.05.2025 12:23:12
// Design Name: 
// Module Name: butterfly_twiddle
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


module butterfly_twiddle (
    input wire clk, rst,
    input wire signed [7:0] ar1, ai1, ar2, ai2,
    input wire signed [7:0] W_r, W_i,
    output reg signed [7:0] cr1, ci1, cr2, ci2
);
    wire signed [15:0] tw_r = (ar2 * W_r) - (ai2 * W_i);
    wire signed [15:0] tw_i = (ar2 * W_i) + (ai2 * W_r);
    wire signed [8:0] tw_r_scaled = tw_r[15:7];
    wire signed [8:0] tw_i_scaled = tw_i[15:7];
    wire signed [8:0] sum_r = ar1 + tw_r_scaled;
    wire signed [8:0] sum_i = ai1 + tw_i_scaled;
    wire signed [8:0] diff_r = ar1 - tw_r_scaled;
    wire signed [8:0] diff_i = ai1 - tw_i_scaled;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            cr1 <= 8'd0; ci1 <= 8'd0;
            cr2 <= 8'd0; ci2 <= 8'd0;
        end else begin
            cr1 <= sum_r > 127 ? 127 : (sum_r < -128 ? -128 : sum_r);
            ci1 <= sum_i > 127 ? 127 : (sum_i < -128 ? -128 : sum_i);
            cr2 <= diff_r > 127 ? 127 : (diff_r < -128 ? -128 : diff_r);
            ci2 <= diff_i > 127 ? 127 : (diff_i < -128 ? -128 : diff_i);
        end
    end
endmodule
