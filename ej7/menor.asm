section .text

global _start
extern numtostr
extern print

_start:
push array
call menor


mov eax, 4
mov ebx, 1
mov ecx, cadena
mov edx, longitud
int 80h

mov eax,1
mov ebx,0
int 80h


menor:
push ebp
mov ebp, esp
push eax
push ebx
push ecx
push edx
mov eax, [ebp+8] ; el array
mov ebx, dword [eax]
.loop:
add eax, 4
cmp dword [eax], -1
je .fin
cmp dword [eax], ebx
jg .loop
mov ebx, dword [eax]
jmp .loop

.fin:
push ebx
push placeholder
call numtostr
sub esp, 8
push placeholder
push 20
call print
sub esp,8

pop edx
pop ecx
pop ebx
pop eax
leave 
ret



section .data
array dd 150,400,129,1000,-1
cadena db 'Fin',10
longitud equ $-cadena



section .bss
placeholder resb 128

