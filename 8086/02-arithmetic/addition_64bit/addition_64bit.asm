.model small
.stack 100H
.data
    ; Each number is split into four 16-bit words, low word first.
    ; Test values are all FFFFH so every word addition overflows,
    ; including a final carry-out beyond the 64th bit.
    A dw 0FFFFH, 0FFFFH, 0FFFFH, 0FFFFH
    B dw 0FFFFH, 0FFFFH, 0FFFFH, 0FFFFH

    ; 5 words: 4 for the 64-bit result, 1 extra to hold the final carry-out.
    C dw 5 dup(?)
.code
main:
    CLC                 ; ensure CF starts at 0 so the first ADC behaves like a plain ADD

    MOV AX, @data
    MOV DS, AX          ; point DS at the data segment so [SI]-style addressing resolves correctly

    MOV CX, 4           ; loop 4 times, once per word
    MOV SI, 0H          ; SI holds the shared offset into A, B, and C

    CALC_LOOP:
        MOV AX, [A + SI]    ; current word of A
        MOV BX, [B + SI]    ; current word of B (same offset)
        ADC AX, BX          ; AX = AX + BX + CF (carry from the previous word, if any)
        MOV [C + SI], AX    ; store this word's result before moving SI
        ADD SI, 2H          ; advance to the next word (2 bytes = 1 word)
        LOOP CALC_LOOP

    ; After the loop, SI points to the 5th word's offset in C.
    ; Capture whatever carry is left in CF the same way: 0 + 0 + CF.
    MOV AX, 0
    ADC AX, 0
    MOV [C + SI], AX

    MOV AH, 4CH
    INT 21H
ret