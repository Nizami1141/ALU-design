module sub3bit(A, B, out);
    input [2:0] A, B;    // 3-bit inputs
    output [3:0] out;    // 4-bit output for subtraction result

    wire [2:0] B_xor_mode;  // B XOR with mode (for subtraction)
    wire [2:0] S;           // Sum signals from full adders
    wire C0, C1, Cout;      // Carry-out signals from full adders

    assign B_xor_mode = B ^ 3'b111; // XOR B with 111 for subtraction (2's complement)

    // Full Adders for Subtraction (using the carry-out properly)
    fulladder FA0 (.A(A[0]), .B(B_xor_mode[0]), .Cin(1'b1), .Sum(S[0]), .Cout(C0)); // First full adder
    fulladder FA1 (.A(A[1]), .B(B_xor_mode[1]), .Cin(C0), .Sum(S[1]), .Cout(C1)); // Second full adder
    fulladder FA2 (.A(A[2]), .B(B_xor_mode[2]), .Cin(C1), .Sum(S[2]), .Cout(Cout)); // Third full adder

    // Combine sum and carry-out to form the final result
    assign out = {Cout, S};  // Output is the carry-out plus the sum
endmodule
