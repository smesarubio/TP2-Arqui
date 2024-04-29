section .text

global _start
extern num_tostr
extern print
extern menor
extern print_array
extern strlen
extern exit

_start:
push ebp
mov ebp, esp
mov edx, ebp
add edx, 0
mov esi,1
mov eax, 0
.loop:
add eax, 1
add edx, 4
cmp dword [edx], 0
je .es_null
jmp .loop
.es_null:
cmp esi, 0
je .fin
dec esi
jmp .loop

.fin:
push eax
push placeholder
call num_tostr

push placeholder
push 20
call print


call exit


section .bss
placeholder resb 128

