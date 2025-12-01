# *Matrix Multiplier*
### *(Source: [Matrix_multiplier.v](../RTL/Matrix_multiplier.v))*

## *About*
- `Matrix_multiplier` is a combinational circuit that multiplies two square matrices of dimension `N × N`.
- Each matrix element has width `DW`.
- The output matrix has dimension `N × N`, with each element sized to safely hold the sum of `N` products.
- Arithmetic expression:
  

\[
  C[i][j] = \sum_{k=0}^{N-1} A[i][k] \cdot B[k][j]
  \]



---

### *Parameters*
- `N` – Matrix dimension (number of rows/columns).
- `DW` – Bit width of each input element.
- `AW` – Bit width of each output element, automatically calculated as `2*DW + $clog2(N)`.

---

## *Instantiation*
To use the `Matrix_multiplier` module in your design:

```verilog
Matrix_multiplier #(
  .N(3),    // Matrix dimension
  .DW(8)    // Width of each element
) u_matmul (
  .A_flat(A_matrix),  // Flattened input matrix A
  .B_flat(B_matrix),  // Flattened input matrix B
  .C_flat(C_matrix)   // Flattened output matrix C = A * B
);
```

Override parameters `N`, `DW` at instantiation.

## *Ports*
| Name   | Direction | Width     | Description              |
|--------|-----------|-----------|--------------------------|
| A_flat   | input     | `N*N*DW` bits    | Flattened input matrix A (row-major)         |
| B_flat   | input     | `N*N*DW` bits    | Flattened input matrix B (row-major)  |
| C_flat   | output    | `N*N*AW` Bits  | Flattened output matrix C = A × B |

## *Edge Cases & Behavior*

- Zero multiplication: If any row or column is all zeros, the corresponding output row/column is zero.
- Maximum values: When all inputs are all-ones, each output element reaches the maximum representable value in AW bits.
- Overflow: No internal overflow occurs because AW is sized to hold the sum of N products. Truncation only happens if later logic reduces the width.
- Unsigned operation: Inputs are treated as unsigned. Signed multiplication requires wrapping with $signed() or modifying the logic.
- Combinational nature: This is a purely combinational block. Synthesis may map it to DSPs or array multipliers. No clock or pipeline stages are included.
