# addition_with_var

A program that adds two values stored as named variables and stores the result back into a third variable, with the result also held in CL as required by the assignment.

## What it does

A (0AH / 10) and B (06H / 6) are declared in the `.data` section as 8-bit variables. C is declared with `?`, reserving space for the result without assigning it a value upfront.

In `.code`, DS is pointed to the data segment via AX (a general purpose register has to be used as an intermediary, since a value can't be moved into DS directly). A and B are then loaded into AL and BL, added together, and the result is moved into CL before being stored back into C.

```
A = 0AH (10)
B = 06H (6)
A + B = 10H (16)
```

Final result: **AL = CL = C = 10H**.

## Why the segment setup is needed

`@data` represents the starting address the assembler assigned to the `.data` section. DS doesn't know this address by default, so it has to be set explicitly at the start of the program — otherwise the CPU has no way of locating A, B, and C in memory.

## Notes

- `.model small` and `.stack 100H` are used here instead of `org 100h`, since this program uses a `.data` section with named variables rather than working purely with immediate values.
- The result is routed through CL specifically per the assignment's instructions, rather than storing AL directly into C.
