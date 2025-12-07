// -----------------------------------------------------------------------------
// Module: pcg  (Permuted Congruential Generator - XSH-RR Variant)
// Author: MrAbhi19
//
// Description:
//   This module implements the 32-bit PCG (Permuted Congruential Generator)
//   using the XSH-RR output permutation. PCG internally uses a 64-bit Linear
//   Congruential Generator (LCG), but with an important constraint:
//
//       The modulus = 2^64
//
//   Because the internal state is stored in a 64-bit register, natural hardware
//   overflow automatically enforces the modulo operation. No explicit `%` is
//   required.
//
//   The PCG algorithm consists of two main steps:
//
//   1. STATE TRANSITION (LCG core)
//        state = state * multiplier + increment   (mod 2^64)
//
//   2. OUTPUT PERMUTATION (XSH-RR):
//        a. Extract high bits of the state
//        b. Mix using XOR
//        c. Compress to 32 bits via shifting
//        d. Rotate right by a value derived from the top 5 bits of state
//
//   This permutation hides the weaknesses of the raw LCG and produces
//   statistically strong 32-bit pseudo-random numbers.
//
// Parameters:
//   A — 64-bit multiplier (default from PCG reference)
//   C — 64-bit increment (must be odd)
//   Both can be tuned to generate distinct independent random streams.
//
// Ports:
//   clk  — Clock input
//   en   — Enable signal; when high, generator advances one step
//   rst  — Reset; initializes the internal state
//   Seed — 64-bit initial seed value
//   out  — 32-bit pseudo-random output
//
// Notes:
//   - Modulus is implicit (wrap-around of 64-bit arithmetic).
//   - Output is 32-bit (PCG-XSH-RR design).
//   - The shifts (18, 27, 59) follow the PCG specification for proper mixing,
//     ensuring high-quality randomness.
// -----------------------------------------------------------------------------

module pcg #(
    parameter [63:0] A = 6364136223846793005,   // PCG default multiplier
    parameter [63:0] C = 1442695040888963407    // Increment (must be odd)
)(
    input              clk,
    input              en,
    input              rst,
    input      [63:0]  Seed,
    output reg [31:0]  out
);

    // Internal 64-bit state register for LCG core
    reg [63:0] state;

    // Temporary values used in XSH-RR permutation
    reg [31:0] xorshifted;
    reg [4:0]  rot;  // Rotate-right amount (0–31)

    always @(posedge clk) begin
        if (rst) begin
            // Initialize internal state from seed
            state <= Seed;

            // Initialize output to any deterministic non-zero function of seed
            // (output doesn't matter here; will update next cycle)
            out <= Seed[63:32] ^ Seed[31:0];

        end else if (en) begin

            // ---------------------------------------------------------------
            // 1. LCG state update (mod 2^64)
            //    Overflow of 64-bit arithmetic automatically performs modulo.
            // ---------------------------------------------------------------
            state <= state * A + C;

            // ---------------------------------------------------------------
            // 2. XSH: Xor-Shift-High output mixing
            //    (state >> 18) discards weak lower bits
            //    XOR mixes upper and lower sections of state
            //    >> 27 compresses to strong 32-bit region
            // ---------------------------------------------------------------
            xorshifted <= ((state >> 18) ^ state) >> 27;

            // ---------------------------------------------------------------
            // 3. RR: rotation amount from top 5 bits of state
            //    Using high bits gives better statistical behavior
            // ---------------------------------------------------------------
            rot <= state[63:59];

            // ---------------------------------------------------------------
            // 4. Final output: rotate-right (ROR) for non-linear scrambling
            //    This hides the linear structure of the LCG
            // ---------------------------------------------------------------
            out <= (xorshifted >> rot) | (xorshifted << ((32 - rot) & 31));

        end
    end

endmodule
