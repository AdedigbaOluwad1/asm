.model small
.stack 100H
.data
    A db 0FFH
    B db 02H
    C dw ?
.code
main:
    MOV AX, @data
    MOV DS, AX
    MOV CH, 0
    MOV AL, A
    MOV BL, B
    ADD AL, BL
    ADC CH, 0
    MOV CL, AL
    MOV C, CX

    MOV AH, 4CH
    INT 21H
ret