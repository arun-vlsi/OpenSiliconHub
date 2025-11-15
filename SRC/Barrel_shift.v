module barrel_shifter #(
  parameter WIDTH = 8 
)(
  input  [WIDTH-1:0] data_in,               
  input  [$clog2(WIDTH)-1:0] shift_amt,       
  input  dir,                                 
  output [WIDTH-1:0] data_out              
);

  assign data_out = dir ? (data_in >> shift_amt) : (data_in << shift_amt);

endmodule
