`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.05.2025 12:24:04
// Design Name: 
// Module Name: log_lut
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


module log_lut (
    input wire clk, rst,
    input wire [7:0] in,
    output reg [7:0] out
);
    reg [7:0] log_table [0:7];

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            log_table[0] <= 8'd0;   // log10(1) = 0
            log_table[1] <= 8'd38;  // log10(2) ≈ 0.3010
            log_table[2] <= 8'd61;  // log10(3) ≈ 0.4771
            log_table[3] <= 8'd77;  // log10(4) ≈ 0.6020
            log_table[4] <= 8'd89;  // log10(5) ≈ 0.6990
            log_table[5] <= 8'd99;  // log10(6) ≈ 0.7782
            log_table[6] <= 8'd108; // log10(7) ≈ 0.8451
            log_table[7] <= 8'd115; // log10(8) ≈ 0.9031
            out <= 8'd0;
        end else begin
            if (in <= 8'd0) begin
                out <= 8'd0;
            end else begin
                out <= log_table[in[7:5]]; // Use top 3 bits
            end
        end
    end
endmodule