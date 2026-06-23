.model small
.stack 100H

.data
    A db 10H
    B db 10H
    C dw ?

.code
main:
    MOV AX, @data
    MOV DS, AX
    MOV AL, A
    MOV DL, B
    MUL DL
    MOV DH, 0
    MOV DL, B
    ADD AX, DX
    MOV C, AX

    MOV AH, 4CH
    INT 21H

ret