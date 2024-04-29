section .text

global _start
extern numtostr
extern print
extern menor
extern print_array
extern strlen

_start:
call print_args

mov eax, 4
mov ebx, 1
mov ecx, cadena
mov edx, longitud
int 80h

mov eax,1
mov ebx,0
int 80h


print_args:
push ebp
mov ebp,esp
push eax
push ebx
push ecx
push edx
mov ecx, 16
.loop:
mov eax, dword [ebp + ecx]
cmp eax, 0
je .fin
mov edx,eax
push edx
call strlen 
sub esp, 4
push edx
push eax
call print
sub esp,8
push line
push line_long
call print
sub esp,8
add ecx, 4
jmp .loop
.fin:
pop edx
pop ecx
pop ebx
pop eax
leave
ret


section .data
cadena db 'Fin',10
line db 10
line_long equ $-line
longitud equ $-cadena


section .bss
placeholder resb 128