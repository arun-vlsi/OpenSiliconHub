module Synchronous_FIFO #(
    parameter WIDTH = 8,    // Data width
    parameter DEPTH = 16    // FIFO depth (must be power of 2)
)(
    input  wire                  clk,
    input  wire                  rst_n,
    input  wire [WIDTH-1:0]      data_in,
    input  wire                  wr_en,
    input  wire                  rd_en,
    output reg  [WIDTH-1:0]      data_out,
    output wire                  full,
    output wire                  empty
);

    // Derived parameters
    localparam ADDR_WIDTH = $clog2(DEPTH);

    // FIFO memory
    reg [WIDTH-1:0] fifo [0:DEPTH-1];

    // Read and write pointers with extra MSB
    reg [ADDR_WIDTH:0] w_ptr, r_ptr;

    // Extract memory addresses (lower bits only)
    wire [ADDR_WIDTH-1:0] w_addr = w_ptr[ADDR_WIDTH-1:0];
    wire [ADDR_WIDTH-1:0] r_addr = r_ptr[ADDR_WIDTH-1:0];

    // Empty when pointers are equal
    assign empty = (w_ptr == r_ptr);

    // Full when write pointer wrapped and caught up to read pointer
    assign full = ({~w_ptr[ADDR_WIDTH], w_addr} == r_ptr);

    // Sequential logic
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            w_ptr    <= 0;
            r_ptr    <= 0;
            data_out <= 0;
        end else begin
            // Write operation
            if (wr_en && !full) begin
                fifo[w_addr] <= data_in;
                w_ptr <= w_ptr + 1;
            end

            // Read operation
            if (rd_en && !empty) begin
                data_out <= fifo[r_addr];
                r_ptr <= r_ptr + 1;
            end
        end
    end

endmodule
