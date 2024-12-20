module counter2bit(clk, reset, out);
    input clk, reset;       // Clock and reset inputs
    output reg [1:0] out;   // 2-bit counter output

    always @(posedge clk or posedge reset) begin
        if (reset)
            out <= 2'b00;
         else
            out <= out + 1;
    end
endmodule