section .bss
Buff resb 1

section .data


section .text

global _start

_start:

Read:  mov eax,3
       mov ebx,0
; Specify sys_read call
               ; Specify File Descriptor 0: Standard Input
mov ecx,Buff ; Pass offset of the buffer to read to
mov edx,1
int 80h
cmp eax,0
je Exit
; Tell sys_read to read one char from stdin
; Call sys_read
 ; Look at sys_read's return value in EAX
 ; Jump If Equal to 0 (0 means EOF) to Exit
 ; or fall through to test for lowercase
cmp byte [Buff],61h  ; Test input char against lowercase 'a'
jb Write        ; If below 'a' in ASCII chart, not lowercase
cmp byte [Buff],7Ah  ; Test input char against lowercase 'z'
ja Write        ; If above 'z' in ASCII chart, not lowercase
                ; At this point, we have a lowercase character
sub byte [Buff],20h ; Subtract 20h from lowercase to give
Write: mov eax,4
       mov ebx,1
       mov ecx,Buff
       mov edx,1
       int 80h
       jmp Read
Exit:  mov eax,1
       mov ebx,0
int 80H
    ; uppercase...
; ...and then write out the char to stdout
; Specify sys_write call
; Specify File Descriptor 1: Standard output
; Pass address of the character to write
; Pass number of chars to write
; Call sys_write...
; ...then go to the beginning to get another
; character
; Code for Exit Syscall
; Return a code of zero to Linux
; Make kernel call to exit program