global _start
extern numtostr
extern print
extern strlen
extern exit
extern print_pid
section .text

_start:
push hola
push longitud
call print
mov eax, 162
push 5
call sleep
push hola
push longitud
call print
call exit


sleep:
push ebp 
mov ebp,esp
push eax
push ebx
mov eax, [ebp + 8]
mov dword [ebp - 4], 0
mov [ebp - 8], eax
mov eax, 162
lea ebx, [ebp - 8]
xor ecx, ecx
int 80h

pop ebx
pop eax
leave 
ret


section .bss
placeholder resb 128

section .data
seconds dd 5
nanoseconds dd 500000000
hola db "Hola" ,10
longitud equ $-hola