.MODEL SMALL
.STACK 100H
.DATA
COUNT DB 0
.CODE

MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

READCHAR:
    MOV AH, 01H
    INT 21H          ; READ CHARACTER INTO AL

    CMP AL, '.'
    JE DISPLAY

    ; CHECK VOWELS (A, E, I, O, U)
    CMP AL, 'A'
    JE INCCOUNT
    CMP AL, 'E'
    JE INCCOUNT
    CMP AL, 'I'
    JE INCCOUNT
    CMP AL, 'O'
    JE INCCOUNT
    CMP AL, 'U'
    JE INCCOUNT

    CMP AL, 'a'
    JE INCCOUNT
    CMP AL, 'e'
    JE INCCOUNT
    CMP AL, 'i'
    JE INCCOUNT
    CMP AL, 'o'
    JE INCCOUNT
    CMP AL, 'u'
    JE INCCOUNT

    JMP READCHAR

INCCOUNT:
    INC COUNT
    JMP READCHAR

DISPLAY:
    MOV DL, COUNT
    ADD DL, 30H      ; CONVERT TO ASCII
    MOV AH, 02H
    INT 21H

    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN