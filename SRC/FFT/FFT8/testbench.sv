module Testbench;

    // Testbench signals
    logic clk = 0;
    logic rst = 1;
    logic start = 0;
    logic done; 
    integer seen_done;

    // Instantiate DUT
    fft8 dut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .done(done)
    );

    // Clock generator: toggles every 5 time units -> 10 time unit period 
    always #5 clk = ~clk;

    // Helper task: wait for one rising clock edge
    task automatic tick;
        @(posedge clk);
    endtask

    initial begin
        $display("TB: starting");

        // Hold reset for several clock cycles
        tick();
        tick();

        rst = 0;
        $display("TB: deassert reset");
        tick();

        // Pulse start high for 1 clock cycle
        start = 1;
        $display("TB: start=1");

        tick(); // DUT samples start=1 on posedge 
    
        start = 0;
        $display("TB: start=0");

        tick();

        // Checking - done must have been high at least once after start pulse
        if (done !== 1'b1) begin
            $display("TB WARNING: done is not 1 right now - this can be normal");
            $display("TB: Check done over next few clock cycles...");
        end

        // Observe 'done' for several cycles and require high value at least once
        seen_done = 0;
        
        repeat (4) begin
            if (done === 1'b1) seen_done = 1;
            tick();
        end

        if (!seen_done) begin
            $display("FAIL: done has never asserted after start pulse");
            $fatal;
        end

        $display("PASS: done asserted at least once after start pulse");
        $finish;
    end

endmodule 