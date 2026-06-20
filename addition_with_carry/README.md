# addition_with_carry

A program that adds two 8-bit values and correctly captures the result even when the addition overflows the 8-bit register holding it, by folding the carry into a second register.

## What it does

A and B are declared as 8-bit variables. Since `addition_with_var` only ever held results that fit safely within 8 bits, this exercise specifically uses values that overflow:

```
A = 0FFH (255)
B = 02H  (2)
A + B = 101H (257)
```

257 doesn't fit in an 8-bit register (max value 255), so `ADD AL, BL` wraps around and sets the Carry Flag (CF) to indicate the result exceeded what AL can hold.

## How the overflow is captured

CH is initialized to 0 before the addition takes place. After `ADD AL, BL`, the instruction `ADC CH, 0` is used — Add with Carry. This computes `CH = CH + 0 + CF`, meaning the only thing that can change CH's value is whatever CF was set to. This is a deliberate use of ADC purely as a way to read the carry bit into a register, rather than for genuine addition.

AL (now holding the wrapped low byte) is moved into CL, and CH:CL together form CX — the full, correct 16-bit result. CX is then stored into C, which is declared as `dw` (16-bit) to hold it.

```
AL after ADD  = 01H (the wrapped low byte)
CH after ADC  = 01H (the captured carry)
CX            = 0101H = 257 decimal
```

## Why MOV ordering doesn't matter here

`MOV` does not affect the flag register, so `MOV CH, 0` can safely happen before or after `ADD AL, BL` without disturbing CF. The only instruction that actually depends on CF here is `ADC`, and it correctly reads whatever CF held at the time `ADD` executed, regardless of how many MOV instructions sit in between.

## Notes

- This builds directly on `addition_with_var`, but is kept as a separate exercise since it solves a distinct problem — overflow handling — rather than being a revision of the original.
- The same ADC-chaining principle extends to wider additions (e.g. 32-bit or 64-bit sums built from multiple 16-bit registers), each ADC carrying the overflow from the previous addition into the next.
