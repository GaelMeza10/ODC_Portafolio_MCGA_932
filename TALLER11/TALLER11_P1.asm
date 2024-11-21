section .data
    num1 db 5             ; Define el primer número (5).
    num2 db 11            ; Define el segundo número (11).
    result db 0           ; Define una variable para almacenar el resultado de la suma (inicialmente 0).
    message db 'Resultado: ', 0  ; Define un mensaje de texto a imprimir antes del resultado.

section .bss
    buffer resb 4         ; Reserva un espacio de 4 bytes para almacenar un número convertido a ASCII.

section .text
global _start

; Macro para imprimir cadenas de texto
%macro PRINT_STRING 1
    mov eax, 4           ; syscall número 4 para escribir (escribir en pantalla).
    mov ebx, 1           ; descriptor de archivo 1 (salida estándar, pantalla).
    mov ecx, %1          ; dirección de la cadena de texto (mensaje).
    mov edx, 13          ; longitud de la cadena.
    int 0x80             ; llamada al sistema para realizar la impresión.
%endmacro

; Macro para imprimir un número en formato de un solo carácter
%macro PRINT_NUMBER 1
    mov eax, %1          ; Cargar el valor numérico a imprimir en el registro EAX.
    add eax, '0'         ; Convertir el número a su representación ASCII sumando el valor '0'.
    mov [buffer], eax    ; Almacenar el carácter ASCII en el buffer.
    mov eax, 4           ; syscall número 4 para escribir (escribir en pantalla).
    mov ebx, 1           ; descriptor de archivo 1 (salida estándar).
    mov ecx, buffer      ; dirección del buffer (donde está el carácter ASCII).
    mov edx, 1           ; longitud del mensaje (un solo carácter).
    int 0x80             ; llamada al sistema para escribir el número.
%endmacro

_start:
    mov al, [num1]       ; Cargar el valor de num1 (5) en el registro AL.
    add al, [num2]       ; Sumar el valor de num2 (11) a AL. AL ahora contiene 16.
    mov [result], al     ; Almacenar el resultado (16) en la variable 'result'.

    ; Imprimir el mensaje "Resultado: "
    PRINT_STRING message  

    ; Imprimir el valor de 'result' (16)
    PRINT_NUMBER [result] 

    ; Finalizar el programa
    mov eax, 1           ; syscall número 1 para terminar el programa.
    mov ebx, 0           ; código de salida 0 (sin errores).
    int 0x80             ; llamada al sistema para terminar el programa.
