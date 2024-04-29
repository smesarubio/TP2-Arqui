section .text

global _start
extern numtostr
extern print
extern menor
extern print_array
extern strlen
extern exit

_start:

push user
call find_env

push dword [ebx]
call strlen

push dword [ebx]
push eax
call print

push line
push line_long
call print

push cadena
push longitud
call print

call exit

;retorna env en ebx
find_env:
push ebp
mov ebp, esp
push eax
mov eax, [ebp + 8]
mov ebx, ebp
add ebx, 24
.loop:
add ebx, 4
push eax
push dword [ebx]
call str_contains
sub esp, 8
cmp esi, 1
je .fin
jmp .loop

.fin:
pop eax
leave
ret




str_contains:
push ebp
mov ebp, esp
xor esi,esi
push eax
push ebx
push ecx
push edx

mov eax, [ebp + 12]
mov ebx, [ebp + 8]
.loop:
cmp byte [eax],0
je .fin_true 
cmp byte [ebx],0
je .fin_false
mov cl, byte [eax]
mov dl, byte [ebx]
cmp cl,dl
jne .fin_false
inc eax
inc ebx
jmp .loop
.fin_true:
mov esi, 1
.fin_false: 
pop edx
pop ecx
pop ebx
pop eax
leave
ret





section .data
cadena db 'Fin',10,0
longitud equ $-cadena
user db 'USER=',0
line db 10
line_long equ $-line


section .bss
placeholder resb 128