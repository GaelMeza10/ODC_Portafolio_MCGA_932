section .data
    num1 db 2                     ; Primer número (ejemplo: 3)
    num2 db 2                     ; Segundo número (ejemplo: 4)
    result db 0                   ; Variable para almacenar el resultado de la suma
    msg db "Resultado: ", 0       ; Mensaje inicial
    resultStr db "00", 10         ; Cadena para el resultado en ASCII y salto de línea
    zeroMsg db "Esto es un cero", 10  ; Mensaje "Esto es un cero" con salto de línea

section .text
    global _start

_start:
    ; Realizar la suma
    mov al, [num1]               ; Cargar el primer número en AL
    add al, [num2]               ; Sumar el segundo número
    mov [result], al             ; Almacenar el resultado de la suma

    ; Verificar si el resultado es cero
    cmp al, 0                     ; Comparar el resultado con 0
    je print_zero                 ; Si es igual a 0, saltar a print_zero

    ; Si el resultado es mayor que 0, convertir a ASCII y mostrarlo
    add al, '0'                  ; Convertir a carácter ASCII
    mov [resultStr], al          ; Guardar el carácter en resultStr para imprimir

    ; Imprimir mensaje de texto
    mov eax, 4                    ; Syscall para escribir
    mov ebx, 1                    ; Salida estándar (stdout)
    mov ecx, msg                  ; Dirección del mensaje
    mov edx, 11                   ; Longitud del mensaje
    int 0x80                      ; Llamada al sistema

    ; Imprimir el resultado de la suma
    mov eax, 4                    ; Syscall para escribir
    mov ebx, 1                    ; Salida estándar (stdout)
    mov ecx, resultStr            ; Dirección de la cadena del resultado
    mov edx, 1                    ; Longitud de la cadena (1 dígito)
    int 0x80                      ; Llamada al sistema

    jmp end_program               ; Saltar al final del programa

print_zero:
    ; Imprimir "Esto es un cero"
    mov eax, 4                    ; Syscall para escribir
    mov ebx, 1                    ; Salida estándar (stdout)
    mov ecx, zeroMsg              ; Dirección del mensaje de cero
    mov edx, 20                   ; Longitud del mensaje
    int 0x80                      ; Llamada al sistema

end_program:
    ; Terminar el programa
    mov eax, 1                    ; Syscall para salir
    xor ebx, ebx                  ; Código de salida 0
    int 0x80                      ; Llamada al sistema
