section .text
global _start

_start:
mov eax, 5
push eax
call gauss

mov eax, 1
mov ebx, 0
int 80h



gauss:
push ebp
mov ebp, esp
push eax
push ebx 
push ecx
push edx
mov eax, [ebp + 8] ;5 en eax
xor ebx, ebx ;ebx=000000000
.loop:
cmp eax, 0
je .fin
add ebx, eax
sub eax,1
jmp .loop
.fin:
push ebx ;15
push placeholder ;espacio de memoria donde guardo "15\n"
call numtostr
mov ecx, placeholder
mov edx, 4
mov eax, 4
mov ebx, 1
int 80h 

pop ebx
pop ebx


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