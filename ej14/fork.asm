global _start
extern numtostr
extern print
extern strlen
extern exit
extern print_pid
section .text

_start:
mov eax,2
int 80h
cmp eax, 0
jne .parent
je .child
.continue:
call exit


.parent:
call print_pid
push padre
push padre_long
call print
jmp .continue

.child:
call print_pid
push hijo
push hijo_long
call print
jmp .continue




section .bss
placeholder resb 128

section .data
hijo db "soy el hijo",10
hijo_long equ $-hijo
padre db "soy el padre",10
padre_long equ $-padre