module fft8 (
    input wire clk,
    input wire rst,
    input wire start,
    output reg done
);
    always @(posedge clk) begin
        if (rst) begin
            done <= 1'b0;
        end else begin
            done <= start; // placeholder: done follows start signal 
        end
    end
endmodule 