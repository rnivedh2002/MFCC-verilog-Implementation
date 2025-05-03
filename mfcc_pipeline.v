`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.05.2025 12:20:23
// Design Name: 
// Module Name: mfcc_pipeline
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

module mfcc_pipeline (
    input wire clk, rst, start,
    input wire [7:0] in_real_0, in_real_1, in_real_2, in_real_3,
    input wire [7:0] in_real_4, in_real_5, in_real_6, in_real_7,
    input wire [7:0] in_imag_0, in_imag_1, in_imag_2, in_imag_3,
    input wire [7:0] in_imag_4, in_imag_5, in_imag_6, in_imag_7,
    output wire [7:0] mfcc0, mfcc1, mfcc2,
    output wire ready, write
);
    // FFT outputs
    wire [7:0] fft_real_0, fft_real_1, fft_real_2, fft_real_3;
    wire [7:0] fft_real_4, fft_real_5, fft_real_6, fft_real_7;
    wire [7:0] fft_imag_0, fft_imag_1, fft_imag_2, fft_imag_3;
    wire [7:0] fft_imag_4, fft_imag_5, fft_imag_6, fft_imag_7;
    wire fft_ready;

    // Mel filter bank outputs
    wire [7:0] mel_out_0, mel_out_1, mel_out_2;

    // Log LUT outputs
    wire [7:0] log_mel_0, log_mel_1, log_mel_2;

    // FFT instantiation
    FFT_8point fft_inst (
        .clk(clk), .reset(rst), .start(start),
        .in0_real(in_real_0), .in1_real(in_real_1), .in2_real(in_real_2), .in3_real(in_real_3),
        .in4_real(in_real_4), .in5_real(in_real_5), .in6_real(in_real_6), .in7_real(in_real_7),
        .in0_imag(in_imag_0), .in1_imag(in_imag_1), .in2_imag(in_imag_2), .in3_imag(in_imag_3),
        .in4_imag(in_imag_4), .in5_imag(in_imag_5), .in6_imag(in_imag_6), .in7_imag(in_imag_7),
        .out0_real(fft_real_0), .out1_real(fft_real_1), .out2_real(fft_real_2), .out3_real(fft_real_3),
        .out4_real(fft_real_4), .out5_real(fft_real_5), .out6_real(fft_real_6), .out7_real(fft_real_7),
        .out0_imag(fft_imag_0), .out1_imag(fft_imag_1), .out2_imag(fft_imag_2), .out3_imag(fft_imag_3),
        .out4_imag(fft_imag_4), .out5_imag(fft_imag_5), .out6_imag(fft_imag_6), .out7_imag(fft_imag_7),
        .ready(fft_ready)
    );

    // Mel filter bank instantiation
    mel_filter_bank mel_inst (
        .clk(clk), .rst(rst),
        .fft_real_0(fft_real_0), .fft_real_1(fft_real_1), .fft_real_2(fft_real_2), .fft_real_3(fft_real_3),
        .fft_real_4(fft_real_4), .fft_real_5(fft_real_5), .fft_real_6(fft_real_6), .fft_real_7(fft_real_7),
        .fft_imag_0(fft_imag_0), .fft_imag_1(fft_imag_1), .fft_imag_2(fft_imag_2), .fft_imag_3(fft_imag_3),
        .fft_imag_4(fft_imag_4), .fft_imag_5(fft_imag_5), .fft_imag_6(fft_imag_6), .fft_imag_7(fft_imag_7),
        .mel_out_0(mel_out_0), .mel_out_1(mel_out_1), .mel_out_2(mel_out_2)
    );

    // Log LUT instantiation
    log_lut log_inst_0 (.clk(clk), .rst(rst), .in(mel_out_0), .out(log_mel_0));
    log_lut log_inst_1 (.clk(clk), .rst(rst), .in(mel_out_1), .out(log_mel_1));
    log_lut log_inst_2 (.clk(clk), .rst(rst), .in(mel_out_2), .out(log_mel_2));

    // DCT instantiation
    dct3 dct_inst (
        .clk(clk), .rst(rst),
        .log_mel_0(log_mel_0), .log_mel_1(log_mel_1), .log_mel_2(log_mel_2),
        .dct_out_0(mfcc0), .dct_out_1(mfcc1), .dct_out_2(mfcc2)
    );

    // Control signals
    assign ready = fft_ready;
    assign write = fft_ready;
endmodule

