section .text
GLOBAL _start
EXTERN print
EXTERN exit
EXTERN str_prefix

;STACK EN CAMPUS
_start:
    push ebp
    mov ebp, esp
    push s2 
    mov edx, [ebp+4] ;stack
    add eax, 4
    mov ecx, 4
    mul ecx ;n+4 * 4
    mov esi, ebp
    add esi, eax  ;iterador
    mov edi, 0   ;flag
.loop:
    cmp edi, 1  ;lo encontre?
    je .fin
    push dword [esi] ;pusheo s1
    call str_prefix
    pop ecx ;popeo la basura
    add esi, 4
    jmp .loop
.fin: 
    push eax
    call print
    mov esp, ebp
    pop ebp
    call exit
section .data
    s2 db "USER=", 0

