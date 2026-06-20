# sum_loop

A program that sums the numbers 10 down to 1 using the `LOOP` instruction.

## What it does

AX is initialized to 0 and acts as the accumulator. CX is initialized to 10 and acts as the loop counter. On each pass through `SUM_LOOP`, the current value of CX is added to AX, then `LOOP` decrements CX and jumps back to `SUM_LOOP` automatically — continuing until CX reaches 0.

```
AX = 0 + 10 + 9 + 8 + 7 + 6 + 5 + 4 + 3 + 2 + 1 = 55
```

Final result: **AX = 55 (37H)**.

## Why LOOP works this way

`LOOP` is built specifically around CX. Every time it executes, it decrements CX by 1 and checks whether CX is 0. If not, it jumps back to the given label; if CX is 0, execution falls through to the next instruction. This is why CX is the designated count register — `LOOP` has no option to use any other register for this purpose.

## Notes

- `org 100h` is used here since this is written as a COM-style program, with code starting at offset 100h.
- The program exits cleanly via `MOV AH, 4CH` / `INT 21H` (DOS terminate function).
