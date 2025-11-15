module Gray_counter #(
  parameter SIZE = 16  
)(
  input  wire clk,
  input  wire reset,
  input  wire en,      
  output reg [$clog2(SIZE)-1:0] gray
);
  localparam WIDTH= (SIZE>1) ? SIZE-1 : 1;
  
  reg [$clog2(SIZE)-1:0] binary;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      binary <= 0;
      gray   <= 0;
    end
    else if (en) begin
      if (binary == $clog2(SIZE)'(WIDTH))
        binary <= 0;
      else
        binary <= binary + 1;

      gray <= ((binary+1) >> 1) ^ (binary+1);
    end
  end
endmodule
