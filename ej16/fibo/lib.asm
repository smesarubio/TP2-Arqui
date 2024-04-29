global numtostr
global print
global menor
global print_array
global strlen
global exit
global to_upper
global sleep

section .text

to_upper:
push ebp
mov ebp,esp
push ebx

mov eax, [ebp + 8]

.loop:

mov bl, byte [eax]
cmp bl,61h
jl  .increment  ;jump if less
cmp bl,7Ah
jg  .increment  ;jump if greater     
sub byte [eax],20h
.increment:
add eax,1
mov bl, byte [eax]
test bl,bl
jne .loop

mov eax, [ebp + 8]

pop ebx
leave
ret


sleep:
push ebp 
mov ebp,esp
push eax
push ebx
mov eax, [ebp + 8]
mov dword [ebp - 4], 0
mov [ebp - 8], eax
mov eax, 162
lea ebx, [ebp - 8]
xor ecx, ecx
int 80h

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



print:
push ebp
mov ebp,esp
push eax
push ebx
push ecx
push edx

mov ecx, [ebp + 12]
mov edx, [ebp + 8]
mov eax, 4
mov ebx, 1
int 80h 

pop edx
pop ecx
pop ebx
pop eax
leave
ret

strlen:
    push ebp            ;armo el stack
    mov ebp, esp
    push ecx            ;pusheo los registros que voy a modificar
    push ebx
    mov ebx, [ebp+8]
    ;no pusheo eax(que tiene dentro a al) pues ahi es donde voy a devolver la longitud

    mov ecx, 0          ;contador en 0
    .loop:
        mov al, [ebx]   ;en AL (1 byte) pongo el valor apuntado por ebx
        cmp al, 0       ;comparo AL con 0
        jz .fin         ;si es 0 salto a fin
        inc ecx         ;incremento contador
        inc ebx         ;muevo al siguiente caracter de la cadena
        jmp .loop
    .fin:
        mov eax, ecx    ;pongo en eax la longitud de la cadena

    pop ebx             ;popeo los registros que modifique
    pop ecx
    mov esp, ebp        ;desarmo el stack
    pop ebp
    ret


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
push placeholder
push 20
call print

pop edx
pop ecx
pop ebx
pop eax
leave 
ret

print_array:
push ebp
mov ebp,esp
push eax
push ebx
push ecx
push edx
mov eax, [ebp+8] ; el array

.loop:
push dword [eax]
push placeholder
call numtostr
push placeholder
call print
add eax, 4
cmp dword [eax], -1
je .fin
jmp .loop

.fin:
pop edx
pop ecx
pop ebx
pop eax
leave 
ret

exit:
mov eax,1
mov ebx,0
int 80h


section .bss
placeholder resb 128