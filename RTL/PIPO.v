module PIPO #(
  parameter SIZE=8
)(
  input wire [SIZE-1:0] in,
  input wire clk,reset,enable,
  output reg [SIZE-1:0] out
);
  always@(posedge clk or posedge reset) begin
    if (reset) begin
      out<=0;
    end
    else if (enable) begin
      out<=in;
    end
  end
endmodule
