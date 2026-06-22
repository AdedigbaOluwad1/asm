# asm

A record of work done while learning assembly language, starting with 8086 as part of FSEN 108. This repository holds the programs written during coursework and independent practice, organized by architecture and exercise.

## Purpose

Assembly is foundational — it forces an understanding of how a processor actually executes instructions, manages memory, and handles data at a low level. This repo exists to keep a clear, organized history of that process: what was attempted, what was learned, and how the understanding developed over time.

It is not a tutorial or a reference library. It's a working log.

## Structure

Programs are organized by architecture first, then by exercise. Each exercise lives in its own folder, named to reflect what the program does. Inside each folder:

- A `.asm` file containing the program
- A `README.md` explaining what the program does, the approach taken, and any relevant details worth noting

```
asm/
├── 8086/
│   ├── 01-registers/
│   ├── 02-arithmetic/
│   │   ├── addition_with_var/
│   │   │   ├── addition_with_var.asm
│   │   │   └── README.md
│   │   ├── addition_with_carry/
│   │   ├── addition_64bit/
│   │   └── sum_loop/
│   ├── 03-control-flow/
│   ├── 04-interrupts/
│   └── bootloader/
├── x86-64/
├── arm64/
└── riscv/
```

The 8086 section reflects coursework from FSEN 108. Later sections will be added as that foundation is solid and the scope expands to modern and alternative architectures.

## Tools

| Architecture | Assembler      | Emulator             |
| ------------ | -------------- | -------------------- |
| 8086         | emu8086 / NASM | emu8086 / QEMU       |
| x86-64       | NASM / GAS     | Native or QEMU       |
| ARM64        | GAS (aarch64)  | QEMU / Apple Silicon |
| RISC-V       | GAS (riscv64)  | QEMU                 |

## Notes

This repository will grow incrementally as new exercises and assignments are completed. Earlier entries reflect earlier stages of understanding and may be revisited or refined over time.
