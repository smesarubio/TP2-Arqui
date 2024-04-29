section .text

global _start
extern print
extern numtostr

_start:
mov eax, 5
push eax
call factorial
push eax
push placeholder
call numtostr
push placeholder
push 20
call print

mov eax,1
mov ebx,0
int 80h


;retorna en eax 
factorial:
push ebp
mov ebp, esp
push ebx
push edx
mov ebx, [ebp + 8] ;5 en ebx
mov eax, ebx ;5 en eax
.loop:
cmp ebx, 1
je .fin
sub ebx, 1 ; 2 en ebx
mul ebx ;5*4*3*2*1 en eax
jmp .loop
.fin:
pop edx
pop ebx
leave 
ret

section .bss
placeholder resb 10

section .data
    cadena db "Hola mundo",10
    longitud equ $-cadena
