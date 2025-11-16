# *Gray Counter*
### *(Source: [Gray_counter.v](../RTL/Gray_counter.v))*
## *About*
- Gray Counter is a sequential circuit that generates Gray code sequences.<br>
- It maintains an internal binary counter and converts its value to Gray code on each clock cycle.<br>
- The output cycles through Gray code values from `0` to `SIZE-1` and wraps around.<br>

### *Parameter*
- `SIZE` – Number of Gray code states. Determines the range of the counter (0 to SIZE-1).

## *Instantiation*
To use the `Gray_counter` module in your design:

```verilog
Gray_counter #(
  .SIZE(16)   // Number of states in Gray code sequence
) u_gray_counter (
  .clk(clk),     // Clock input
  .reset(rst),   // Reset input (active high)
  .en(enable),   // Enable counting
  .gray(gray_out)// Gray code output
);
```
Override parameters `SIZE` at instantiation.

### Ports
| Name   | Direction | Width     | Description              |
|--------|-----------|-----------|--------------------------|
| clk   | input     | 1-bit           | 	Clock input             |
| reset | input     | 1-bit           | Reset input (active high) |
| en    | input     | 1 bit           | 	Enable signal           |
| gray  | output    | log2(SIZE) bits | Gray code output          |

## *Edge Cases & Behavior*
- Reset:<br> When reset=1, both binary and Gray outputs are set to 0.
- Enable:<br> Counter increments only when en=1. If en=0, output holds its value.
- Wrap-around:<br> When binary counter reaches SIZE-1, it resets back to 0.
- Gray code generation:<br> Gray output is computed as (binary+1 >> 1) ^ (binary+1), ensuring only one bit changes between successive states.
- Sequential nature:<br> Updates occur on rising edge of clk or reset. Synthesizable as flip-flops with combinational Gray conversion logic.
- Sequential nature:<br> Updates occur on rising edge of clk or reset. Synthesizable as flip-flops with combinational Gray conversion logic.
