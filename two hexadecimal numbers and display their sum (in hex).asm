ORG 100h

.MODEL SMALL
.STACK 100h

.DATA
msg1 DB 'Enter first hex digit (0-F): $'
msg2 DB 0Ah,0Dh,'Enter second hex digit (0-F): $'
msgResult DB 0Ah,0Dh,'Sum (in hex) = $'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Ask first digit
    MOV AH, 09h
    LEA DX, msg1
    INT 21h
    MOV AH, 01h
    INT 21h
    MOV BL, AL         ; store first hex char

    ; Ask second digit
    MOV AH, 09h
    LEA DX, msg2
    INT 21h
    MOV AH, 01h
    INT 21h
    MOV BH, AL         ; store second hex char

    ; Convert ASCII to numeric value
    CALL HexToValue
    MOV CL, AL         ; save first number
    MOV AL, BH
    CALL HexToValue

    ADD AL, CL         ; add both
    CMP AL, 0Ah
    JB belowA
    ADD AL, 37h        ; convert to ASCII (A-F)
    JMP display
belowA:
    ADD AL, 30h        ; convert 0–9 to ASCII

display:
    MOV AH, 09h
    LEA DX, msgResult
    INT 21h
    MOV DL, AL
    MOV AH, 02h
    INT 21h

    ; Exit
    MOV AH, 4Ch
    INT 21h

;---------------------------
; Converts ASCII hex ('0'-'9','A'-'F') to value (0–15)
;---------------------------
HexToValue PROC
    CMP AL, '9'
    JG letter
    SUB AL, '0'
    RET
letter:
    SUB AL, 55          ; 'A' (65) - 55 = 10
    RET
HexToValue ENDP

MAIN ENDP
END MAIN
