.model small
.stack 100H

.data
    A db 10H
    B db 10H
    C db ?

.code
main:
    MOV AX, @data
    MOV DS, AX
    MOV AL, A
    MOV BL, B
    ADD AL, AL
    SUB AL, BL
    MOV C, AL
    
    MOV AH, 4CH
    INT 21H
ret


