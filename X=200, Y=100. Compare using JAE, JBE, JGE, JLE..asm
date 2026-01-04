.MODEL SMALL
.STACK 100H

.DATA
X DB 200    ; X = 200
Y DB 100    ; Y = 100

MSGUNSIGNEDABOVE DB "UNSIGNED: X >= Y (JAE)", 13, 10, "$"
MSGUNSIGNEDBELOW DB "UNSIGNED: X <= Y (JBE)", 13, 10, "$"

MSGSIGNEDGREATER DB "SIGNED: X >= Y (JGE)", 13, 10, "$"
MSGSIGNEDLESS DB "SIGNED: X <= Y (JLE)", 13, 10, "$"

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ;===========================
    ; UNSIGNED COMPARISON
    ;===========================
    MOV AL, X
    MOV BL, Y
    CMP AL, BL

    JAE UNSIGNEDABOVE     ; X >= Y (unsigned)
    JBE UNSIGNEDBELOW     ; X <= Y (unsigned)

UNSIGNEDABOVE:
    MOV DX, OFFSET MSGUNSIGNEDABOVE
    MOV AH, 09H
    INT 21H
    JMP SIGNEDPART

UNSIGNEDBELOW:
    MOV DX, OFFSET MSGUNSIGNEDBELOW
    MOV AH, 09H
    INT 21H
    JMP SIGNEDPART

    ;===========================
    ; SIGNED COMPARISON
    ;===========================
SIGNEDPART:
    MOV AL, X
    MOV BL, Y
    CMP AL, BL

    JGE SIGNEDGREATER     ; X >= Y (signed)
    JLE SIGNEDLESS        ; X <= Y (signed)

SIGNEDGREATER:
    MOV DX, OFFSET MSGSIGNEDGREATER
    MOV AH, 09H
    INT 21H
    JMP FINISH

SIGNEDLESS:
    MOV DX, OFFSET MSGSIGNEDLESS
    MOV AH, 09H
    INT 21H
    JMP FINISH

FINISH:
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN
