.model small
.stack 100H
.data
    A db 0AH
    B db 06H
    C db ?
.code
main:
    MOV AX, @data
    MOV DS, AX
    MOV AL, A
    MOV BL, B
    ADD AL, BL
    MOV CL, AL
    MOV C, CL

    MOV AH, 4CH
    INT 21H
ret