// Module for Full Adder
module fulladder(A, B, Cin, Sum, Cout, P, G);
    input A, B, Cin;  // Inputs
    output Sum, Cout; // Sum and Carry-out
    output P, G;      // Propagate and Generate

    assign P = A | B; // Propagate
    assign G = A & B; // Generate
    assign Sum = A ^ B ^ Cin; // Sum
    assign Cout = G | (P & Cin); // Carry-out
endmodule