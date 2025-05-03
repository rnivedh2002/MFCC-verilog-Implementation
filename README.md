MFCC Verilog Pipeline
This repository hosts a Verilog HDL implementation of an 8-bit Mel-Frequency Cepstral Coefficient (MFCC) pipeline tailored for low-resource FPGAs. The pipeline is designed for real-time speech feature extraction, enabling applications like speech synthesis in resource-constrained environments. It processes audio signals through pre-emphasis, FFT, Mel filter bank, logarithm, and DCT stages, using 8-bit fixed-point arithmetic for efficiency.
Project Overview
The MFCC pipeline aims to deliver low-latency, resource-efficient speech processing. Key metrics include:

Resource Usage: 1.51% LUTs (2026/133,800), 0.16% FFs (431/267,600), 1.49% DSPs (11/740), 39.25% IOs (157/400).
Latency: ~1100 ns (11 clock cycles at 100 MHz).
Power: 88.781 W total, with 98% dynamic power, though high junction temperature (125.0°C) poses thermal challenges.

Modules
The project includes the following Verilog modules:

src/butterfly_twiddle.v: Stores twiddle factors for FFT.
src/butterfly.v: Implements a butterfly stage for FFT.
src/dct3.v: Computes 3-point DCT for MFCC coefficients.
src/log_lut.v: Performs logarithm via lookup table.
src/mel_filter_bank.v: Applies Mel-scale filtering.
src/pre_emphasis.v: Enhances high-frequency components.
src/mfcc_pipeline.v: Integrates all stages.
testbenches/tb_mfcc_pipeline.v: Testbench with inputs (e.g., -64, 64, 32).

Current Limitations

No Framing or Windowing: The pipeline lacks framing and windowing stages, essential for audio segmentation and spectral smoothing. MFCCs are currently computed directly from FFT inputs, which may affect accuracy.
Incomplete Modules: The fft_8point module, critical for the FFT stage, is referenced but not implemented in this repository, limiting full functionality.

Future Work
To address limitations and enhance performance, the following tasks are planned:

Framing and Windowing: Develop modules for signal framing and windowing (e.g., Hamming window) to improve spectral analysis.
Thermal Mitigation: Add heat sinks or lower clock frequency to manage 125.0°C junction temperature.
I/O Optimization: Implement pin multiplexing to reduce 39.25% I/O usage.
Enhanced Accuracy: Introduce dynamic range scaling or additional Mel filter bands for better frequency resolution.
Real-World Synthesis: Synthesize on a Xilinx Spartan-6 FPGA to validate hardware performance.
Complete Module Set: Implement fft_8point and ensure all modules are fully functional.

Getting Started

Clone the Repository:git clone https://github.com/your-username/mfcc-verilog-pipeline.git


Add Verilog Files: Place module files in src/ and testbenches in testbenches/.
Simulate: Use Vivado to run tb_mfcc_pipeline.v with inputs like -64, 64, 32.
Synthesize: Target a low-resource FPGA (e.g., Xilinx Spartan-6) for synthesis.

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

Contributing
Contributions are welcome! Please open an issue or submit a pull request for enhancements, especially for framing/windowing or missing modules.
