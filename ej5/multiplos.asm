
section .text
global _start

_start:
mov eax, 2
mov ebx, 5
push eax
push ebx
call multiplos

mov eax, 1
mov ebx, 0
int 80h


multiplos:
push ebp
mov ebp, esp
push eax
push ebx 
push ecx
push edx
mov ecx, [ebp + 12] ;n 
mov ebx, [ebp + 8]  ;k
mov edx, 0
.loop:
add edx, 1
cmp edx, ebx
jg .fin
mov eax, edx

push edx
mul ecx
pop edx

push eax
push placeholder
call numtostr
sub esp, 8
push placeholder
push 10
call print
sub esp, 8


jmp .loop


.fin:
pop edx
pop ecx
pop ebx 
pop eax
leave
ret

print:
push ebp
mov ebp,esp
push eax
push ebx
push ecx
push edx

mov ecx, [ebp + 8]
mov edx, 20
mov eax, 4
mov ebx, 1
int 80h 

pop edx
pop ecx
pop ebx
pop eax
leave
ret




numtostr:
push ebp
mov ebp,esp
push eax
push ebx
push ecx
push edx
mov eax, dword [ebp+12]  ;mi numero en eax
mov ebx, dword [ebp+8]    ;mi posicion de memoria en ebx
.div:
mov ecx, 10
xor edx,edx
div ecx
test al,al
jz .test_dl
jmp .sigue
.test_dl:
test dl,dl                   ;test al,dl   ;nose xq aca no funciona el jz    
jz .reverse
.sigue:
add dl, 30h
mov byte [ebx], dl
add ebx, 1
jmp .div
.reverse:
mov byte [ebx],10
xor ecx,ecx
.loop_push:
mov ebx, dword [ebp+8]
add ebx,ecx
movzx ebx, byte [ebx]
cmp bl, 10
je .pop
push ebx
add ecx,1
jmp .loop_push
.pop:
mov ebx, dword [ebp+8]
.loop_pop:
cmp ecx,0
je .fin
pop eax
mov byte [ebx], al
sub ecx,1
add ebx,1
jmp .loop_pop
.fin:
pop edx
pop ecx
pop ebx
pop eax
leave
ret

section .data

section .bss
placeholder resb 10