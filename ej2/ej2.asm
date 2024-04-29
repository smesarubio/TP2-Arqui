;Ejercicio 2
;Hacer un programa que defina, en una zona de datos, una cadena de caracteres con el siguiente string: “h4ppy c0d1ng” y la convierta a mayúscula. El resultado debe ser “H4PPY C0D1NG”. Muestre por consola el resultado. Utilice como convención que los strings están terminados en 0. Implemente funciones.

section .data 
string db "H4ppy c0d1ng",10,0
longitud equ $-string


section .text

global _start

_start:
mov eax,string

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

mov ecx,string
mov edx, longitud
mov eax,4
mov ebx,1
int 80h
mov eax,1
mov ebx,0
int 80h



