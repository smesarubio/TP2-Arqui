global _start
extern numtostr
extern print
extern strlen
extern exit
extern print_pid
extern to_upper

section .text

_start:

call read
push placeholder
call to_upper
call strlen
push eax
call print
call exit


read:
push ebp
mov ebp, esp
push ebx
push ecx
mov eax, 3
mov ebx, 0
mov ecx, placeholder
mov edx, 128
int 80h

pop ecx
pop ebx
leave
ret


section .bss
placeholder resb 128

section .data

seconds dd 5
nanoseconds dd 500000000
hola db "hola soy sanchu" ,10
longitud equ $-hola