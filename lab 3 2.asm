ORG 100h           ; Required for .COM file programs

.MODEL SMALL
.STACK 100h

.DATA
msgHello DB 0Ah,0Dh, 'Hello World$',0
msgBye   DB 0Ah,0Dh, 'Bye World$',0
count    DB 0        ; Counter initialized to 0

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX       ; Initialize data segment

PRINT_LOOP:
    ; Print "Hello World"
    MOV AH, 09h
    LEA DX, msgHello
    INT 21h

    ; Increment counter
    INC count

    ; Compare counter with 5
    MOV AL, count
    CMP AL, 5
    JE PRINT_BYE      ; If count == 5, jump to print "Bye World"
    JNE PRINT_LOOP    ; Else, repeat loop

PRINT_BYE:
    MOV AH, 09h
    LEA DX, msgBye
    INT 21h

    ; Exit program
    MOV AH, 4Ch
    INT 21h

MAIN ENDP
END MAIN
