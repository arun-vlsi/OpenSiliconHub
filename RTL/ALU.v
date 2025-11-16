module ALU #(
  parameter SIZE=8
)(
  input wire [SIZE-1:0] A,
  input wire [SIZE-1:0] B,
  input wire [2:0] sel,
  output reg [SIZE:0] out
);
  always@(*) begin
    case(sel)
      3'b000: out=A+B;
      3'b001: out=A-B;
      3'b010: out={1'b0,A|B};
      3'b011: out={1'b0,A&B};
      3'b100: out={1'b0,A^B};
      3'b101: out={1'b0,~(A|B)};
      3'b110: out={1'b0,~(A&B)};
      3'b111: out={1'b0,~(A^B)};
      default: out={SIZE+1{1'b0}};
    endcase
  end
endmodule
