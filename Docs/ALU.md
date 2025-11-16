# *ALU*
### *(Source: [ALU.v](../RTL/ALU.v))*

## *About*
- ALU (Arithmetic Logic Unit) is a combinational circuit that performs arithmetic and logical operations on two binary inputs.<br>
- It has 2 inputs of size `WIDTH`, a 3-bit select signal to choose the operation, and one output of size `WIDTH+1`.<br>
- Supported operations include addition, subtraction, bitwise OR, AND, XOR, NOR, NAND, and XNOR.

### *Parameter*
- WIDTH – Bit width of inputs `A` and `B`.

## *Instantiation*
To use the `ALU` module in your design:

```verilog
ALU #(
  .WIDTH(8)   // Width of inputs A and B
) u_alu (
  .A(dataA),   // Input A
  .B(dataB),   // Input B
  .sel(opSel), // Select signal for operation
  .out(result) // Output based on sel
);
```
Override parameters `WIDTH` at instantiation.

## *Ports*
| Name   | Direction | Width     | Description              |
|--------|-----------|-----------|--------------------------|
| A      | input     | WIDTH bits| First operand            |
| B      | input     | WIDTH bits| Second operand           |
| sel    | input     | 3-bits    | Operation Select         |
| out    | output    | A+B bits  |Result of selected operation|

## *Edge Cases & Behavior*

- Addition/Subtraction:<br> Output width is WIDTH+1 to capture carry/borrow.

- Bitwise operations (OR, AND, XOR):<br> Output is padded with a leading 0 to match WIDTH+1.

- Inverted operations (NOR, NAND, XNOR):<br> Output is also padded with a leading 0.

- Default case:<br> If sel is outside 000–111, output is forced to all zeros.

- Unsigned operation:<br> Inputs are treated as unsigned. Signed arithmetic requires wrapping with $signed().

- Combinational nature:<br> Purely combinational block. Synthesis may map arithmetic to adders/subtractors and logic ops to gates. No clock or pipeline stages are included.
