module ALU(clk, A, B, seg, an);
    input clk;
    input [2:0] A, B; // 3-bit inputs
    output [6:0] seg; // Seven-segment display for output
    output [3:0] an;  // Anodes for display (to control which 7-segment is active)

    // Wires for internal connections
    wire [3:0] cla_out, sub_out, mux_out; // Outputs from CLA, Subtractor, and MUX
    wire [1:0] counter_out; // Counter output to select which operation to display
    wire [3:0] anode_signal; // Decoded signal to control anodes of the display

    reg [3:0] add_ones, add_tens; // For addition result (ones and tens place)
    reg [3:0] sub_ones;           // For subtraction result (ones place)

    // Instantiate components
    cla3bit cla(.A(A), .B(B), .out(cla_out)); // 3-bit CLA adder
    sub3bit sub(.A(A), .B(B), .out(sub_out)); // 3-bit subtractor
    counter2bit counter(.clk(clk), .reset(1'b0), .out(counter_out)); // 2-bit counter for switching between add and sub
    dec2to4 decoder(.in(counter_out), .out(anode_signal)); // 2-to-4 decoder to generate anode signals
    mux4to1 multiplexer(
        .in0(cla_out[3:0]),   // Input for addition (A + B)
        .in1({3'b000, cla_out[3]}),  // Handle carry-over bit
        .in2(sub_out[3:0]),   // Input for subtraction (A - B)
        .in3(4'b0000),         // Default zero value (not used here)
        .sel(counter_out),     // Select between the inputs based on the counter
        .out(mux_out)          // Output of the multiplexer (the result to display)
    );
    bcd2sseg bcd_to_seg(.bcd(mux_out), .seg(seg)); // BCD to 7-segment display conversion

    // Always block for handling addition logic (A + B)
    always @(posedge clk)
    begin
        if (cla_out > 9) // Check if sum exceeds 9
        begin
            // If the sum is greater than 9, handle the carry
            add_ones <= cla_out - 10; // Subtract 10 to get the ones place
            add_tens <= 1;             // Set the tens place to 1
        end
        else
        begin
            add_ones <= cla_out; // No carry, just set the ones place
            add_tens <= 0;        // Tens place is 0
        end
    end

    // Always block for handling subtraction logic (A - B)
    always @(posedge clk)
    begin
        if (B > A) // Check if B is greater than A (negative result)
        begin
            sub_ones <= 0; // If B > A, the result is negative; set to zero or handle underflow as needed
        end
        else
        begin
            sub_ones <= sub_out[3:0]; // Otherwise, take the subtraction result
        end
    end
endmodule
