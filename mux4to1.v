module mux4to1(in0, in1, in2, in3, sel, out);
    input [3:0] in0, in1, in2, in3; // 4-bit inputs
    input [1:0] sel;                // Select lines
    output reg [3:0] out;           // 4-bit output

    always @(*) begin
        case (sel)
            2'b00: out = in0;
            2'b01: out = in1;
            2'b10: out = in2;
            2'b11: out = in3;
            default: out = 4'b0000;
        endcase
    end
endmodule
