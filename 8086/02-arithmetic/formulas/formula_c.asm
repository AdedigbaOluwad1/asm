.model small
.stack 100H

.data
    DIVIDEND db 011H
    DIVISOR db 10H
    QUOTIENT db ?
    REMAINDER db ? 

.code
main: 
  MOV AX, @data
  MOV DS, AX
  MOV AH, 0
  MOV AL, DIVIDEND
  MOV DL, DIVISOR
  DIV DL
  MOV QUOTIENT, AL
  MOV REMAINDER, AH

  MOV AH, 4CH
  INT 21H

ret
    