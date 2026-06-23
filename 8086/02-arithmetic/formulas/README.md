# formulas

A set of programs implementing arithmetic expressions in 8086 assembly. Each program computes a formula using byte-sized variables and stores the result in memory. The set covers addition, subtraction, multiplication, division, and their signed equivalents.

---

## Programs

### formula_a — C = A + A - B

Loads `A` and `B` as unsigned bytes. Adds `A` to itself, then subtracts `B`. The result fits in a byte and is stored in `C` as an 8-bit value.

No multiplication or division is involved, so no register promotion is needed. The entire computation stays in `AL`.

---

### formula_b — C = A² + B (unsigned)

Multiplies `A` by itself using `MUL`. The result lands in `AX` as a 16-bit value — multiplication always produces a double-width result on 8086, so `C` is declared as a word (`dw`).

Before adding `B` to `AX`, `B` must be promoted to 16 bits. Since the values are unsigned, `DH` is set to `0` and `DL` holds `B`, making `DX` a zero-extended 16-bit representation of `B`. The addition then proceeds cleanly.

---

### formula_b_signed — C = A² + B (signed)

Same structure as `formula_b`, but uses `IMUL` for signed multiplication and handles sign-extension manually before the addition.

After reloading `B` into `DL`, `DH` is set by copying `DL` into it and then applying `SAR DH, 7`. This arithmetic right shift fills every bit of `DH` with the sign bit of `DL` — producing `00h` for positive values and `FFh` for negative ones. `DX` then holds the correct signed 16-bit representation of `B` before the addition.

---

### formula_c — C = B / A (unsigned)

Loads `B` as the dividend into `AL` and clears `AH` to zero before dividing. On 8086, unsigned byte division takes a 16-bit dividend from `AX` and divides by an 8-bit operand. Zeroing `AH` ensures the upper byte of the dividend is clean.

After `DIV`, the quotient is in `AL` and the remainder is in `AH`. Both are stored to their respective memory locations.

---

### formula_c_signed — C = B / A (signed)

Same structure as `formula_c`, but uses `IDIV` and replaces the manual `MOV AH, 0` with `CBW`.

`CBW` (Convert Byte to Word) sign-extends `AL` into `AH` — filling `AH` with `FFh` if `AL` is negative, or `00h` if positive. This is the signed equivalent of zeroing `AH` and ensures the dividend is correctly represented as a signed 16-bit value before the division.

---

## Key concepts

**Double-width results:** `MUL` and `IMUL` always store their result across two registers (`AX` for 8-bit operands). This is why `C` is declared as `dw` in the multiplication programs — the result can exceed 8 bits.

**Promoting 8-bit values before addition:** After multiplication, `AX` is 16-bit. Adding an 8-bit value directly is not possible — the operand must first be promoted to 16 bits via `DX`. For unsigned values, `DH` is zeroed. For signed values, `DH` is derived from the sign bit of `DL` using `SAR DH, 7`.

**`CBW` for signed division:** Before `IDIV`, the dividend in `AL` must be sign-extended into `AH`. `CBW` handles this in one instruction, correctly producing either `00h` or `FFh` in `AH` depending on the sign of `AL`.
