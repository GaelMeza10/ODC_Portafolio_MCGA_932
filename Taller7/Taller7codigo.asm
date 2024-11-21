section .data 
    num1 db 5                    ; Definir num1 con valor 5
    num2 db 11                   ; Definir num2 con valor 11
    result db 0                  ; Variable para almacenar el resultado de la suma
    msg db 'Resultado:', 0       ; Mensaje a imprimir seguido de un terminador nulo

section .bss
    buffer resb 1                ; Reservar 1 byte para almacenar el carácter ASCII del resultado

section .text
    global _start                ; Declarar el punto de entrada global
_start:
    ; Sumar num1 y num2
    mov al, [num1]              ; Cargar el valor de num1 en el registro AL
    add al, [num2]              ; Sumar el valor de num2 a AL
    mov [result], al            ; Almacenar el resultado de la suma en 'result'

    ; Convertir el resultado a ASCII
    movzx eax, byte [result]    ; Cargar el resultado en EAX (extendiendo a 32 bits)
    add al, 48                  ; Convertir el valor numérico a su representación ASCII ('0' = 48)

    ; Almacenar el carácter ASCII en el buffer
    mov [buffer], al            ; Guardar el carácter ASCII en el buffer

    ; Imprimir el mensaje
    mov eax, 4                  ; syscall: sys_write
    mov ebx, 1                  ; file descriptor: stdout (salida estándar)
    mov ecx, msg                ; puntero al mensaje
    mov edx, 10                 ; longitud del mensaje a imprimir
    int 0x80                    ; Llamar al kernel para realizar la escritura

    ; Imprimir el resultado
    mov eax, 4                  ; syscall: sys_write
    mov ebx, 1                  ; file descriptor: stdout (salida estándar)
    mov ecx, buffer             ; puntero al buffer que contiene el carácter ASCII
    mov edx, 1                  ; imprimir 1 byte (el carácter ASCII)
    int 0x80                    ; Llamar al kernel para realizar la escritura

    ; Salir
    mov eax, 1                  ; syscall: sys_exit
    xor ebx, ebx                ; establecer el estado de salida a 0
    int 0x80                    ; Llamar al kernel para salir
