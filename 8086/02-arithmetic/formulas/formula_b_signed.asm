.model small
.stack 100H

.data
    A db -05H
    B db 03H
    C dw ?

.code
main:
    MOV AX, @data
    MOV DS, AX
    MOV AL, A
    MOV DL, B
    IMUL DL
    MOV DL, B
    MOV DH, DL
    SAR DH, 7
    ADD AX, DX
    MOV C, AX

    MOV AH, 4CH
    INT 21H

ret