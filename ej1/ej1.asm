section .text

global _start

_start:
mov ecx, cadena
mov edx, longitud
mov eax,4
mov ebx,1
int 80h

mov eax,1
mov ebx,0
int 80h

section .data
cadena db "Hello World", 10
longitud equ $-cadena

