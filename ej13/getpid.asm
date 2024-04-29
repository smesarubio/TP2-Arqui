global _start
extern numtostr
extern print
extern strlen
extern exit

section .text

_start:
mov eax, 20
int 80h
push eax
push placeholder
call numtostr
push placeholder
call strlen
push placeholder
push eax
call print
call exit

section .bss
placeholder resb 128