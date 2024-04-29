section .text

global _start
extern numtostr
extern print
extern menor
extern print_array
extern exit

_start:
call cant_args
push eax
push placeholder
call numtostr
push placeholder
call print

call exit

;retorna en eax
cant_args:
push ebp
mov ebp, esp

mov eax, [ebp+8]
dec eax

leave
ret





mov eax, 4
mov ebx, 1
mov ecx, cadena
mov edx, longitud
int 80h

mov eax,1
mov ebx,0
int 80h



section .data
cadena db 'Fin',10
longitud equ $-cadena


section .bss
placeholder resb 128