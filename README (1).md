# MFCC Verilog Pipeline

This repository hosts a Verilog HDL implementation of an 8-bit Mel-Frequency Cepstral Coefficient (MFCC) pipeline for low-resource FPGAs, aimed at real-time speech feature extraction. The pipeline supports speech synthesis applications, with a future goal of enabling communication for mute individuals through deep learning classifier integration.

## Project Overview
The MFCC pipeline processes audio signals using 8-bit fixed-point arithmetic across pre-emphasis, FFT, Mel filter bank, logarithm, and DCT stages. Key metrics:
- **Resource Usage**: 1.51% LUTs (2026/133,800), 0.16% FFs (431/267,600), 1.49% DSPs (11/740), 39.25% IOs (157/400).
- **Latency**: ~1100 ns (11 cycles at 100 MHz).
- **Power**: 88.781 W, with high junction temperature (125.0°C).

### Modules
- `src/butterfly_twiddle.v`: Twiddle factors for FFT.
- `src/butterfly.v`: FFT butterfly stage.
- `src/fft_8point.v`: 8-point FFT implementation.
- `src/dct3.v`: 3-point DCT for MFCC coefficients.
- `src/log_lut.v`: Logarithm lookup table.
- `src/mel_filter_bank.v`: Mel-scale filtering.
- `src/pre_emphasis.v`: High-frequency enhancement.
- `src/mfcc_pipeline.v`: Top-level pipeline integration.
- `testbenches/tb_mfcc_pipeline.v`: Testbench with inputs (e.g., -64, 64, 32).

### Current Limitations
- **Incompatible Framing/Windowing**: Framing and windowing modules were implemented but are not compatible with the FFT, so MFCCs are derived directly from FFT to DCT, potentially affecting spectral accuracy.
- **Module Errors**: All modules, including `fft_8point`, are implemented but exhibit timing errors, high power consumption (88.781 W), and elevated junction temperature (125.0°C), requiring code rectification.

### Future Work
- **Code Rectification**: Fix timing errors and optimize code to reduce power consumption and junction temperature.
- **Pipelining**: Implement pipelining to enhance performance and throughput.
- **Compatible Framing and Windowing**: Develop FFT-compatible framing and windowing modules (e.g., Hamming window) for improved spectral analysis.
- **Deep Learning Integration**: Integrate with a deep learning classifier to classify MFCC features for speech synthesis, aiding mute individuals.
- **Thermal Mitigation**: Add heat sinks or lower clock frequency to manage 125.0°C junction temperature.
- **I/O Optimization**: Use pin multiplexing to reduce 39.25% I/O usage.
- **Enhanced Accuracy**: Implement dynamic range scaling or additional Mel filter bands.
- **Real-World Synthesis**: Synthesize on Xilinx Spartan-6 for hardware validation.

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
│   ├── fft_8point.v
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
Submit issues or pull requests for timing fixes, pipelining, framing/windowing, or deep learning integration.

