`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.05.2025 12:25:03
// Design Name: 
// Module Name: tb_mfcc_pipeline
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

 module tb_mfcc_pipeline;
    reg clk, rst, start;
    reg [7:0] in_real_0, in_real_1, in_real_2, in_real_3;
    reg [7:0] in_real_4, in_real_5, in_real_6, in_real_7;
    reg [7:0] in_imag_0, in_imag_1, in_imag_2, in_imag_3;
    reg [7:0] in_imag_4, in_imag_5, in_imag_6, in_imag_7;
    wire [7:0] mfcc0, mfcc1, mfcc2;
    wire ready, write;

    // Instantiate MFCC pipeline
    mfcc_pipeline uut (
        .clk(clk), .rst(rst), .start(start),
        .in_real_0(in_real_0), .in_real_1(in_real_1), .in_real_2(in_real_2), .in_real_3(in_real_3),
        .in_real_4(in_real_4), .in_real_5(in_real_5), .in_real_6(in_real_6), .in_real_7(in_real_7),
        .in_imag_0(in_imag_0), .in_imag_1(in_imag_1), .in_imag_2(in_imag_2), .in_imag_3(in_imag_3),
        .in_imag_4(in_imag_4), .in_imag_5(in_imag_5), .in_imag_6(in_imag_6), .in_imag_7(in_imag_7),
        .mfcc0(mfcc0), .mfcc1(mfcc1), .mfcc2(mfcc2),
        .ready(ready), .write(write)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 100 MHz
    end

    // Test stimulus
    initial begin
        rst = 1;
        start = 0;
        in_real_0 = -8'd64; in_real_1 = -8'd64; in_real_2 = -8'd64; in_real_3 = -8'd64;
        in_real_4 = -8'd64; in_real_5 = -8'd64; in_real_6 = -8'd64; in_real_7 = -8'd64;
        in_imag_0 = 8'd0;   in_imag_1 = 8'd0;   in_imag_2 = 8'd0;   in_imag_3 = 8'd0;
        in_imag_4 = 8'd0;   in_imag_5 = 8'd0;   in_imag_6 = 8'd0;   in_imag_7 = 8'd0;

        #200 rst = 0;
        #20 start = 1;
        #10 start = 0;

        #10000;
        $display("MFCC Outputs: mfcc0 = %d, mfcc1 = %d, mfcc2 = %d", mfcc0, mfcc1, mfcc2);
        $stop;
    end
endmodule
