# addition_64bit

A program that adds two 64-bit numbers using the 8086's native 16-bit registers, by splitting each number into four 16-bit words and chaining the carry across them with a loop.

## The core problem

The 8086 has no register wide enough to hold a 64-bit value directly. `addition_with_carry` solved this for two 8-bit values overflowing into a 16-bit result by manually capturing the carry with ADC. This exercise extends the same principle to a much larger scale: two 64-bit numbers, each represented as four separate 16-bit words, added word by word with the carry chained from one word to the next.

## Data layout

```
A dw 0FFFFH, 0FFFFH, 0FFFFH, 0FFFFH
B dw 0FFFFH, 0FFFFH, 0FFFFH, 0FFFFH
C dw 5 dup(?)
```

A and B are each declared as a single label pointing to four contiguous words, listed low word first. This matters: declaring four separate named variables (e.g. A_W1, A_W2, A_W3, A_W4) would not guarantee they sit next to each other in memory, since the assembler is free to place individually named labels anywhere. A single label with a comma-separated list of values guarantees a contiguous block, which is required for offset-based addressing to work correctly.

C is declared as five words rather than four. Adding two 64-bit numbers can produce a result that no longer fits in 64 bits, so the fifth word exists specifically to hold that final carry-out, the same way CH held the overflow in the 8-bit case.

## Why one index register is enough for three arrays

SI provides an offset, not a fixed address. `[SI]` alone resolves to `DS:SI`, meaning it has no inherent connection to where A, B, or C actually start in memory. Writing `[A + SI]` instead means "the address of A, plus whatever offset SI currently holds." Since A, B, and C all use the same offsets in parallel (the Nth word of each corresponds to the same step in the loop), a single index register can walk through all three arrays in lockstep, rather than needing a separate dedicated pointer for each one.

## Why CLC matters

ADC always computes `destination + source + CF`, with no variant that skips the carry. Since every word addition in the loop uses ADC (including the first), CF needs to be guaranteed 0 before the loop begins, otherwise the first word could pick up an unrelated carry left over from an earlier instruction. CLC explicitly clears CF before MOV DS, AX and the loop, ensuring the first ADC behaves identically to a plain ADD.

## The loop

```
CLC
SI = 0
repeat 4 times:
    AX = word at A + SI
    BX = word at B + SI
    AX = AX + BX + CF      (ADC)
    word at C + SI = AX
    SI = SI + 2
```

Each pass handles one word pair, writes the result before advancing SI, and leaves CF set correctly for the next pass to consume. The loop runs exactly four times, once per word, controlled by CX.

## Capturing the final carry

After the loop, SI has advanced to the offset of the fifth word in C. Since CF cannot be written to memory directly, it is captured the same way it was in `addition_with_carry`: a register is set to 0, then ADC is applied with 0 as the source, so the only thing that can change the register's value is CF. That result is then stored into the fifth word of C.

## Test values and expected result

To verify the carry logic actually executes (rather than coincidentally never triggering), every word of A and B is set to FFFFH, the maximum value a word can hold. This forces every single word addition to overflow, including a final carry-out beyond the 64th bit.

```
Word 1: FFFF + FFFF          = 1FFFE  -> low word FFFE, carry out
Word 2: FFFF + FFFF + carry  = 1FFFF  -> low word FFFF, carry out
Word 3: FFFF + FFFF + carry  = 1FFFF  -> low word FFFF, carry out
Word 4: FFFF + FFFF + carry  = 1FFFF  -> low word FFFF, carry out
Final carry captured into the fifth word
```

Expected result in C, low word to high word:

```
FFFE, FFFF, FFFF, FFFF, 0001
```

Confirmed correct via the Variables window in emu8086 after running.

## Notes

- This builds on the carry-handling concept from `addition_with_carry`, extended from a single 8-bit overflow into a four-word chain.
- The same approach generalizes to any width: more words simply mean more loop iterations and one wider result array, with the loop body itself unchanged.
