# *Serial-In Serial-Out (SISO) Register*
### *(Source: [SISO.v](../RTL/SISO.v))*
## *About*
- SISO (Serial-In Serial-Out) register is a sequential circuit that shifts serial input data through a register and outputs it serially.<br>
- It loads one bit per clock cycle and shifts data until all bits have passed through.<br>
- Commonly used in serial communication systems, shift registers, and data buffering.<br>

### *Parameter*
- `WIDTH` – Number of bits in the shift register.

## *Instantiation*
To use the `SISO` module in your design:

```verilog
SISO #(
  .WIDTH(8)   // Width of the shift register
) u_siso (
  .in(serial_in),   // Serial input bit
  .clk(clk),        // Clock input
  .reset(rst),      // Reset input (active high)
  .enable(en),      // Enable shifting
  .out(serial_out), // Serial output bit
  .done(done),      // Signals completion of shifting
  .busy(busy)       // Indicates active shifting
);
```
Override parameters `WIDTH` at instantiation.

### Ports
| Name   | Direction | Width     | Description              |
|--------|-----------|-----------|--------------------------|
| in    | input     | 1 bit      | 	Serial input bit   |
| clk   | input     | 1 bit      | Clock input  |
| reset | input     | 1 bit      | 	Reset input (active high)   |
| enable| input     | 1 bit      | Enable signal |
| out   | output    | 1 bit      |  Serial output bit |
| done  | output    | 1 bit      | Signals completion of shifting |
| busy  | output    | 1 bit      | Indicates active shifting operation |

## *Edge Cases & Behavior*
- Reset:<br> When reset=1, output and internal counters are cleared.
- Enable:<br> Shifting occurs only when enable=1. If enable=0, outputs remain idle (busy=0, done=0).
- Shift operation:<br> Input bit is shifted into the register each cycle, while the MSB is shifted out.
- Completion:<br> When all bits are shifted, done=1 and busy=0. Counter resets to 0 for next operation.
- Sequential nature:<br> Updates occur on rising edge of clk or reset. Synthesizable as flip-flops with shift logic.
- Parameterization:<br> Register length is determined by WIDTH. Output sequence length matches register size.
