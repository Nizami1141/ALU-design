`timescale 1ns / 1ps

// Module for 3-bit Carry Look-Ahead Adder
module cla3bit(A, B, out);
    input [2:0] A, B;  // 3-bit inputs
    output [3:0] out;  // 4-bit output for sum (includes carry-out)

    wire [2:0] P, G;    // Propagate and Generate signals
    wire [3:0] carry;   // Carry signals
    wire [2:0] S;       // Sum signals

    // Instantiate Full Adders with Propagate and Generate Outputs
    fulladder FA0 (.A(A[0]), .B(B[0]), .Cin(carry[0]), .P(P[0]), .G(G[0]), .Sum(S[0]));
    fulladder FA1 (.A(A[1]), .B(B[1]), .Cin(carry[1]), .P(P[1]), .G(G[1]), .Sum(S[1]));
    fulladder FA2 (.A(A[2]), .B(B[2]), .Cin(carry[2]), .P(P[2]), .G(G[2]), .Sum(S[2]));

    // Carry Logic
    assign carry[0] = 0;                          // Initial carry is 0
    assign carry[1] = G[0] | (P[0] & carry[0]);   
    assign carry[2] = G[1] | (P[1] & carry[1]);   
    assign carry[3] = G[2] | (P[2] & carry[2]);   

    // Combine carry-out with sum
    assign out = {carry[3], S};
endmodule
