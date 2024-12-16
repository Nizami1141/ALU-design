module sub3bit(A, B, out);
    input [2:0] A, B;  // 3-bit inputs
    output [3:0] out;  // 4-bit output for subtraction result

    wire [2:0] B_xor_mode;  // B XOR with mode (1 for subtraction)
    wire [2:0] S;           // Sum signals
    wire Cout;              // Carry-out from subtraction

    assign B_xor_mode = B ^ 3'b111; // XOR with mode to subtract

    // Full Adders for Subtraction
    fulladder FA0 (.A(A[0]), .B(B_xor_mode[0]), .Cin(1'b1), .Sum(S[0]), .Cout(C0));
    fulladder FA1 (.A(A[1]), .B(B_xor_mode[1]), .Cin(C0), .Sum(S[1]), .Cout(C1));
    fulladder FA2 (.A(A[2]), .B(B_xor_mode[2]), .Cin(C1), .Sum(S[2]), .Cout(Cout));

    assign out = {Cout, S};  // Combine carry-out with sum
endmodule

