.model small

.stack 100h

.data

msg db 0ah,0dh, "Hello, World $"

.code

main proc

start: 

mov ah,9 ; print function is 9. 

lea dx,msg ; load offset of msg into dx.

int 21h ; do it!

jmp start