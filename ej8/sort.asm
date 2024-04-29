section .text

global _start
extern numtostr
extern print
extern menor
extern print_array


_start:
push array
call sort

push array
call print_array


mov eax, 4
mov ebx, 1
mov ecx, cadena
mov edx, longitud
int 80h

mov eax,1
mov ebx,0
int 80h


sort:
push ebp
mov ebp, esp
push eax
push ebx
push ecx
push edx
mov eax, [ebp +8] ; array en eax
.loop:
cmp dword [eax], -1
je .fin
push eax
call menor_index
sub esp, 4
mov edx, dword [eax]
mov dword [eax], ebx
mov dword [ecx], edx
add eax, 4
jmp .loop
.fin:
pop edx
pop ecx
pop ebx
pop eax
leave
ret



;retorna en ebx y ecx el menor y el indice del menor
menor_index:
push ebp
mov ebp, esp
push eax
push edx
mov eax, [ebp+8] ; el array
mov ebx, dword [eax]
mov ecx, eax
.loop:
add eax, 4
cmp dword [eax], -1
je .fin
cmp dword [eax], ebx
jg .loop
mov ebx, dword [eax]
mov ecx, eax
jmp .loop

.fin:

pop edx
pop eax
leave 
ret





section .data
array dd 15,40,2,20,-1
cadena db 'Fin',10
longitud equ $-cadena


section .bss
placeholder resb 128