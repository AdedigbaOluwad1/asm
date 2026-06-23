.model small
.stack 100H

.data
    DIVIDEND db -011H
    DIVISOR db 10H
    QUOTIENT db ?
    REMAINDER db ? 

.code
main: 
  MOV AX, @data
  MOV DS, AX
  MOV AL, DIVIDEND
  CBW
  MOV DL, DIVISOR
  IDIV DL
  MOV QUOTIENT, AL
  MOV REMAINDER, AH

  MOV AH, 4CH
  INT 21H

ret
    