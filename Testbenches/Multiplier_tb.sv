module Multiplier_tb;
  // Parameters
  localparam WIDTH_A = 4;
  localparam WIDTH_B = 6;

  // DUT signals
  logic [WIDTH_A-1:0] in1;
  logic [WIDTH_B-1:0] in2;
  logic [WIDTH_A+WIDTH_B-1:0] out;

  // DUT instantiation
  Multiplier #(.WIDTH_A(WIDTH_A), .WIDTH_B(WIDTH_B)) dut (
    .in1(in1),
    .in2(in2),
    .out(out)
  );

  // Waveform dump
  initial begin
    $dumpfile("tb_multiplier.vcd");   // waveform file
    $dumpvars(0, Multiplier_tb);      // dump all signals in this testbench
  end

  // Stimulus
  initial begin
    // Directed tests
    in1 = 4'd3; in2 = 6'd5; #10;
    $display("3*5 = %0d, DUT = %0d", 3*5, out);

    in1 = 4'd7; in2 = 6'd9; #10;
    $display("7*9 = %0d, DUT = %0d", 7*9, out);

    $finish;
  end
endmodule
