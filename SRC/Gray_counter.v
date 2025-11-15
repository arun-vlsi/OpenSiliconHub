module gray_counter #(
  parameter SIZE = 16  
)(
  input  wire clk,
  input  wire reset,
  input  wire en,      
  output reg [$clog2(SIZE)-1:0] gray
);

  reg [$clog2(SIZE)-1:0] binary;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      binary <= 0;
      gray   <= 0;
    end
    else if (en) begin
      if (binary == SIZE-1)
        binary <= 0;
      else
        binary <= binary + 1;

      gray <= (binary >> 1) ^ binary;
    end
  end
endmodule
