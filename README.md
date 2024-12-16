# ALU Design with Carry Look-Ahead Adder and Subtractor

This repository contains the implementation of an Arithmetic Logic Unit (ALU) designed using Verilog for the AX4010 FPGA. The ALU supports 3-bit addition and subtraction, leveraging a carry look-ahead adder for efficient computation. This README provides an overview of the design, its modules, and the steps to simulate and test the implementation.

---

## Features

- **Addition:** Implements a 3-bit carry look-ahead adder for fast computation.
- **Subtraction:** Uses a 3-bit adder-subtractor circuit with XOR logic for subtraction.
- **Multiplexed Display:** Displays addition and subtraction results on a 7-segment display.
- **Additional Components:** Includes modules for a 2-bit counter, 2-to-4 decoder, and BCD to 7-segment conversion.

---

## Modules

### 1. Carry Look-Ahead Adder (`cla3bit`)

- Adds two 3-bit numbers using propagate and generate logic.
- Outputs a 4-bit result (3-bit sum and 1 carry-out).

#### Verilog Example

```verilog
module cla3bit(A, B, out);
    input [2:0] A, B;
    output [3:0] out;
    wire [2:0] P, G, S;
    wire [3:0] carry;

    assign carry[0] = 0;
    assign carry[1] = G[0] | (P[0] & carry[0]);
    assign carry[2] = G[1] | (P[1] & carry[1]);
    assign carry[3] = G[2] | (P[2] & carry[2]);
    assign out = {carry[3], S};
endmodule
```

### 2. Subtractor (`sub3bit`)

- Subtracts two 3-bit numbers by XORing one input with `111` (2's complement subtraction).
- Outputs a 4-bit result (3-bit difference and 1 carry-out).

### 3. Multiplexed Display (`mux4to1`)

- Uses a 4-to-1 multiplexer to cycle between displaying addition, subtraction, or no operation on a 7-segment display.
- Controlled by a 2-bit counter and decoder.

### 4. Other Modules

- **Full Adder (****`fulladder`****)**: Computes sum and carry-out for each bit.
- **2-Bit Counter (****`counter2bit`****)**: Cycles through operations.
- **2-to-4 Decoder (****`dec2to4`****)**: Activates the correct 7-segment display.
- **BCD to 7-Segment Converter (****`bcd2sseg`****)**: Converts binary-coded decimal to 7-segment display encoding.

---

## Simulation and Testing

### 1. Simulation

- Use Vivado to simulate the `cla3bit` and `sub3bit` modules.
- Test with sample inputs: `A=5, B=3`, `A=7, B=7`, `A=3, B=6`, `A=0, B=0`.
- Verify correct outputs for addition and subtraction.

### 2. Testing on AX4010 FPGA

- Update the constraints file to map FPGA pins to switches, buttons, and displays on the AX4010.
- Program the FPGA with the generated bitstream.
- Use switches to input values for `A` and `B`, and verify outputs on the 7-segment display.

#### Constraints File Example

```xdc
set_property PACKAGE_PIN W5 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
set_property PACKAGE_PIN V17 [get_ports {A[0]}]
set_property PACKAGE_PIN V16 [get_ports {A[1]}]
set_property PACKAGE_PIN U18 [get_ports {A[2]}]
set_property PACKAGE_PIN W18 [get_ports {B[0]}]
set_property PACKAGE_PIN W17 [get_ports {B[1]}]
set_property PACKAGE_PIN W16 [get_ports {B[2]}]
```

---

## Deliverables

1. **Verilog Code:** Source files for all modules.
2. **Simulation Waveforms:** Screenshots showing results for various inputs.
3. **Truth Tables:**
   - 2-bit adder and subtractor truth tables.
4. **Schematics:**
   - Drawings of the carry look-ahead adder and adder-subtractor.

---

## Future Work

- Add a 2-bit multiplier module.
- Implement overflow detection in the adder-subtractor circuit.

---
