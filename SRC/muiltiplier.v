module multiplier #(
  parameter A=4,
  parameter B=6
)(
  input [A-1:0] in1,
  input [B-1:0] in2,
  output [A+B-1:0] out
);
  assign out=in1*in2;
endmodule
