GLOBAL print
GLOBAL exit
GLOBAL capitalize
GLOBAL num_tostr
GLOBAL multiplier
GLOBAL factorial
GLOBAL min_from_array
GLOBAL sort_array
GLOBAL print_array
GLOBAL str_prefix
section .text

print:
    push ebp        ;armo el stack
    mov ebp, esp
    push ecx
    push edx
    push eax
    push ebx
    
    call strlen     ;calculo la longitud de la cadena (la retorna a eax)
    mov ecx, [ebp+8]     ;la cadena esta en ebx
    mov edx, eax    ;la longitud de la cadena esta en eax

    mov eax, 4      ;system call a WRITE
    mov ebx, 1
    int 80h

    pop ebx
    pop eax
    pop edx
    pop ecx
    mov esp, ebp    ;desarmo el stack
    pop ebp
    ret


;Calcula la longitud de una cadena terminada en 0

strlen:
    push ebp            ;armo el stack
    mov ebp, esp
    pushf               ;pusheo los flags
    push ecx            ;pusheo los registros que voy a modificar
    push ebx
    mov ebx, [ebp+32]
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
    popf                ;popeo los flags
    mov esp, ebp        ;desarmo el stack
    pop ebp
    ret

capitalize:
    push ebp
    mov ebp, esp
    push ecx
    push eax
    pushf

    mov ecx, [ebp+8]
    .loop:
        mov al, [ecx]       ;muevo la direccion de la cadena (primer byte) a al (registro de 1 byte)
        cmp al, 0          ;comparo a al con 0
        jz .done            ;si la comparacion da 0 (al es 10) salto a done
        cmp al, 61          ;comparo al con 61 (hexa de 97, ascii de la a)
        jl .increment       ;si al es menor que 61 salto a increment
        cmp al, 7Ah         ;comparo al con 7A (hexa de 122, ascii de la z)
        jg .increment
        sub al, 20h         ;le resto al 20h para pasar a mayuscula
        mov [ecx], al       ;guardo en la posicion correspondiente de ecx (un byte) a al
    .increment:
        inc ecx             ;incremento ecx para pasar al siguiente byte (siguiente caracter)
        jmp .loop           ;salto a loop
    .done:
        popf
        pop eax
        pop ecx
        mov esp, ebp
        pop ebp
        ret                 ;termino la funcion


num_tostr:
    push ebp 
    mov ebp, esp 
    push ecx
    push edx
    push eax

    mov eax, [ebp + 12] ; numero 
    mov ecx, 10 

    push 0 ; asi se donde termina el numero 

    mov edx, 0 ;por como funciona la division
    cmp eax, 0 ; veo si es cero paso directo a imprimirlo
    je .to_char

    .loop:
        mov edx, 0 ;por como funciona la division
        cmp eax, 0 ; veo si termino mi numero 
        je .string ; paso a crear el string para imprimir
        div ecx ; hago la division 
        jmp .to_char
    .to_char:
        add edx, '0' ; cambio el numero a un caracter 
        push edx ; valor del resto en char 
        jmp .loop
    .string:
        mov ecx, [ebp + 8] ; lugar de memoria para guardar 
        .loop2:
            pop eax
            cmp eax, 0
            je .fin
            mov [ecx],al
            inc ecx
            jmp .loop2
    .fin:
        mov [ecx], byte 10
        inc ecx
        mov [ecx], byte 0
        pop eax
        pop edx 
        pop ecx 
        mov esp, ebp
        pop ebp
        ret

multiplier:
    ;k esta en ebp+12
    ;n esta en ebp+8
    push ebp
    mov ebp, esp
    cmp dword [ebp+12], 1  ;veo si k es mayor a 1
    jl .fin
    mov ecx, 1  ;contador
    ;esto es para el num_tostr
    push eax
    push dword [ebp+16]
.loop:
    cmp dword [ebp+12], ecx ;comparo el contador con k
    jl .fin   ;si es mayor me voy
    mov eax, ecx  ;copio el contador
    mul dword [ebp+8]  ;multiplico el contador por n
    inc ecx
    mov ebx, dword [ebp+16]  ;paso zona de memoria para num_tostr
    mov [ebp-4], eax  ;pusheo el resultado para num_tostr
    call num_tostr
    call print
    jmp .loop
.fin:
    mov esp, ebp
    pop ebp
    ret

factorial:
    push ebp
    mov ebp, esp
    mov eax, 1
    cmp dword [ebp + 8], 0
    je .fin
    jl .error ;la idea es uasr la misma comp
    ;cmp dword [ebp + 8], 0
    ;jl .error
    mov ecx, dword [ebp+8] ;me guardo el numero en ecx
.loop:
    cmp ecx, 1
    je .fin
    mul ecx
    dec ecx
    jmp .loop
.fin:
    push eax
    push dword [ebp+12]
    mov ebx, dword [ebp+12]  ;mando la zona de memoria para el num_tostr
    mov [ebp-4], eax ;NI IDEAAA pero funciona
    call num_tostr
    call print
    mov esp, ebp
    pop ebp
    ret
.error: ;despiues vemos que queremos imprimir
    mov esp, ebp
    pop ebp
    ret


min_from_array:
    push ebp
    mov ebp, esp

    mov ebx, dword [ebp+8] ; en ebx tenemos el puntero al array
    cmp dword [ebx], -1
    je .fin2
    mov eax, dword [ebx]
    mov ecx, ebx  ;me guardo la direccion de memoria de la rta
.loop:
    add ebx, 4  ;sumo 4 porque es dd
    cmp dword [ebx], -1
    je .fin
    cmp dword [ebx], eax
    jg .loop
    mov eax, dword [ebx]
    mov ecx, ebx  ;me guardo la direccion de memoria de la rta
    jmp .loop
.fin:
    mov esp, ebp
    pop ebp
    ret
.fin2:
    mov eax, -1
    jmp .fin
sort_array:
    push ebp
    mov ebp, esp

    mov edx, dword [ebp+8]  ;guardo el puntero al array
;voy achicando el array despues de hacer el swap
.loop:
    push edx  ;puntero al primer lugar 
    call min_from_array ;eax esta el numero y en ebx esta la referencia
    cmp eax, -1
    je .fin
    ;swap
    mov esi, dword [edx] ;copio el numero en esi. AUX
    mov dword [edx], eax ;me guardo el menor
    mov dword [ecx], esi ;lo piso con el auxiliar
    ;achico el array
    add edx, 4
    jmp .loop
.fin:
    mov esp, ebp
    pop ebp
    ret

print_array:  ;void print_array(array)
    push ebp
    mov ebp, esp

    mov edx, dword [ebp+8]
.loop:
    cmp dword [edx], -1  ;si esta vacio me fui
    je .fin 
    mov eax, dword [edx]
    push eax
    push placeholder
    call num_tostr
    call print
    add edx, 4
    jmp .loop
.fin:
    mov esp, ebp
    pop ebp
    ret
;|          |
;------------0000
;| ebp main |   <-- esp, ebp
;------------
;|   ret    |  +4
;------------
;|    s1    |  +8  ;ESTO ES LO QUE POPEO
;------------  
;|    s2    |  +12 ;"USER=" 
;------------
;|   ebp    |  
;------------ffff
;int str_cmp(char *s1, char *s2)

str_prefix:
    push ebp
    mov ebp, esp

    mov eax, dword [ebp+8] ;lo hay q en el stack
    mov ebx, dword [ebp+12] ;"USER=" PARA EL STRLEN
    mov edi, 0 ;flag de encontrado
.loop:  
    cmp dword [ebx], 0 ;"USER=" termino
    je .fin2
    mov dl, byte [eax] ;caracter del stack
    cmp dl, byte [ebx] ;comparo letra con letra
    jz .continue
    jnz .fin
.continue:
    inc eax
    inc ebx
    jmp .loop
.fin2: ;lo encontre
    mov edi, 1
.fin:  ;no lo encontre o me fui
    mov esp, ebp
    pop ebp
    ret

exit:
    push ebp        ;armo el stack
    mov ebp, esp
    push eax
    push ebx

    mov eax, 1      ;system call a EXIT
    mov ebx, 0
    int 80h

    pop ebx
    pop eax
    mov esp, ebp    ;desarmo el stack
    pop ebp
    ret

section .bss
placeholder resb 128 ;"un numero pasado a string no vale 4 bytes"