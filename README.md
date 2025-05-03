MFCC Verilog Pipeline

This repository contains a Verilog HDL implementation of an 8-bit Mel-Frequency Cepstral Coefficient (MFCC) pipeline designed for low-resource FPGAs, targeting real-time speech feature extraction for speech synthesis applications. The pipeline processes audio signals through a series of stages to generate MFCC coefficients, optimized for low latency and minimal resource usage.

Project Overview

The MFCC pipeline is designed to extract cepstral features from audio inputs using 8-bit fixed-point arithmetic. It includes stages for pre-emphasis, FFT, Mel filter bank, logarithm computation, and discrete cosine transform (DCT). The design achieves low resource utilization (e.g., 1.51% LUTs, 0.16% FFs) and a latency of ~1100 ns at 100 MHz, but faces challenges with high power consumption (88.781 W) and I/O utilization (39.25%).

Modules





butterfly_twiddle.v: Stores twiddle factors for FFT.



butterfly.v: Implements a butterfly stage for FFT.



dct3.v: Performs 3-point DCT for MFCC coefficients.



log_lut.v: Computes logarithms using a lookup table.



mel_filter_bank.v: Applies Mel-scale filtering.



tb_mfcc_pipeline.v: Testbench for the MFCC pipeline.



pre_emphasis.v: Enhances high-frequency signal components.



mfcc_pipeline.v: Top-level module integrating all stages.

Current Issues





Missing Framing and Windowing: The pipeline lacks framing and windowing stages, which are critical for segmenting audio signals and reducing spectral leakage. Currently, MFCC coefficients are derived directly from FFT inputs.



Incomplete Module Set: Some modules (e.g., fft_8point) are referenced but not fully implemented in this repository.

Future Work





Framing and Windowing: Add modules for audio signal framing and windowing (e.g., Hamming window) to improve spectral analysis.



Thermal Mitigation: Implement heat sinks or reduce clock frequency to manage high junction temperatures (125.0°C).



I/O Optimization: Use pin multiplexing to reduce I/O utilization (39.25%).



Enhanced Accuracy: Explore dynamic range scaling or additional Mel filter bands for better frequency resolution.



Real-World Synthesis: Synthesize on a target FPGA (e.g., Xilinx Spartan-6) to validate hardware performance.



Complete Module Set: Develop or include missing modules (e.g., fft_8point) for a fully functional pipeline.

Setup Instructions





Clone the Repository:

git clone https://github.com/your-username/mfcc-verilog-pipeline.git



Add Modules: Place Verilog files in the src/ directory.



Simulate: Use Vivado to run the tb_mfcc_pipeline.v testbench.



Synthesize: Target a low-resource FPGA for synthesis.

Directory Structure

mfcc-verilog-pipeline/
├── src/
│   ├── butterfly_twiddle.v
│   ├── butterfly.v
│   ├── dct3.v
│   ├── log_lut.v
│   ├── mel_filter_bank.v
│   ├── pre_emphasis.v
│   ├── mfcc_pipeline.v
├── testbenches/
│   ├── tb_mfcc_pipeline.v
├── README.md
├── .gitignore
