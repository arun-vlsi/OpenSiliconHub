module MAC_tb;
  parameter WIDTH_A=5;
  parameter WIDTH_B=7;

  logic [WIDTH_A-1:0] A;
  logic [WIDTH_B-1:0] B;
  logic [WIDTH_A+WIDTH_B-1:0] C;
  logic [WIDTH_A+WIDTH_B-1:0] out;

  MAC #(.WIDTH_A(WIDTH_A), .WIDTH_B(WIDTH_B) ) dut (
    .A(A),
    .B(B),
    .C(C),
    .out(out)
  );

  initial begin 
    A=5'd13; B=7'd23; c=12'd1012; #10;
    $display ("(13*23)+1012= %d, DUT=%0d",(13*23)+1012,out);
    
    A=5'd15; B=7'd21; c=12'd598; #10;
    $display ("(15*21)+598= %d, DUT=%0d",(15*21)+598,out);

    $finish;
  end
endmodule
