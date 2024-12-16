module dec2to4(in, out);
    input [1:0] in;  // 2-bit input
    output [3:0] out; // 4-bit output

    assign out = 1 << in; // Shift logic to generate active high output
endmodule
