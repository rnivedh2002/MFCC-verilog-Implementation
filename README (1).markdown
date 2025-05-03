# MFCC Verilog Pipeline

This repository contains a Verilog HDL implementation of an 8-bit Mel-Frequency Cepstral Coefficient (MFCC) pipeline for low-resource FPGAs, designed for real-time speech feature extraction in speech synthesis applications. The pipeline processes audio signals through pre-emphasis, FFT, Mel filter bank, logarithm, and DCT stages, optimized for low latency and minimal resource usage.

## Project Overview
The MFCC pipeline delivers efficient speech processing with:
- **Resource Usage**: 1.51% LUTs (2026/133,800), 0.16% FFs (431/267,600), 1.49% DSPs (11/740), 39.25% IOs (157/400).
- **Latency**: ~1100 ns (11 cycles at 100 MHz).
- **Power**: 88.781 W, with thermal challenges (125.0°C junction temperature).

### Modules
- `src/butterfly_twiddle.v`: Twiddle factors for FFT.
- `src/butterfly.v`: FFT butterfly stage.
- `src/dct3.v`: 3-point DCT for MFCC coefficients.
- `src/log_lut.v`: Logarithm lookup table.
- `src/mel_filter_bank.v`: Mel-scale filtering.
- `src/pre_emphasis.v`: High-frequency enhancement.
- `src/mfcc_pipeline.v`: Top-level pipeline integration.
- `testbenches/tb_mfcc_pipeline.v`: Testbench with inputs (e.g., -64, 64, 32).

### Current Limitations
- **No Framing/Windowing**: The pipeline lacks framing and windowing, critical for audio segmentation and spectral smoothing. MFCCs are computed directly from FFT inputs, potentially reducing accuracy.
- **Incomplete Modules**: The `fft_8point` module is missing, preventing full pipeline functionality.

### Future Work
- **Framing and Windowing**: Add modules (e.g., Hamming window) for improved spectral analysis.
- **Thermal Mitigation**: Use heat sinks or lower clock frequency to address 125.0°C junction temperature.
- **I/O Optimization**: Implement pin multiplexing to reduce 39.25% I/O usage.
- **Enhanced Accuracy**: Add dynamic range scaling or more Mel filter bands.
- **Real-World Synthesis**: Synthesize on Xilinx Spartan-6 for hardware validation.
- **Complete Module Set**: Implement `fft_8point` and ensure all modules are functional.

## Getting Started
1. **Clone the Repository**:
   ```bash
   git clone https://github.com/your-username/mfcc-verilog-pipeline.git
   ```
2. **Add Modules**: Place Verilog files in `src/` and testbenches in `testbenches/`.
3. **Simulate**: Run `tb_mfcc_pipeline.v` in Vivado with inputs like -64, 64, 32.
4. **Synthesize**: Target a low-resource FPGA (e.g., Xilinx Spartan-6).

## Directory Structure
```plaintext
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
```

## Contributing
Submit issues or pull requests for enhancements, especially for framing/windowing or missing modules.

