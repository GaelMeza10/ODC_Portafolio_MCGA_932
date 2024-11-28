section .data
    msg db "Resultado:", 0          ; Mensaje a imprimir seguido de un terminador nulo
    newline db 0xA                  ; Nueva línea

section .bss
    res resb 4                      ; Espacio para el resultado

section .text
    global _start

_start:
    ; Instrucciones aritméticas
    mov eax, 10
    mov ebx, 5
    add eax, ebx

    ; Instrucción lógica (AND)
    and eax, 0xF                    ; Instrucción lógica 0xF ES IGUAL A 15

    ; Instrucciones de manipulación de bits
    shl eax, 1                      ; Desplazamiento hacia la izquierda (multiplicación por 2)

    ; Guardar el resultado en la sección .bss
    mov [res], eax

    ; Llamar a la rutina para imprimir el resultado
    mov eax, 4                      ; syscall: sys_write
    mov ebx, 1                      ; file descriptor: stdout (salida estándar)
    mov ecx, msg                    ; dirección del mensaje a imprimir
    mov edx, 11                     ; longitud del mensaje
    int 0x80                        ; Interrupción para realizar la escritura

    ; Imprimir el número (resultado almacenado en 'res')
    mov eax, [res]                  ; Cargar el resultado en EAX
    add eax, '0'                    ; Convertir el número en carácter ASCII
    mov [res], eax                  ; Almacenar el carácter convertido
    mov eax, 4                      ; syscall: sys_write
    mov ebx, 1                      ; file descriptor: stdout
    mov ecx, res                    ; dirección del resultado
    mov edx, 1                      ; longitud del carácter
    int 0x80                        ; Interrupción para realizar la escritura

    ; Imprimir nueva línea
    mov eax, 4                      ; syscall: sys_write
    mov ebx, 1                      ; file descriptor: stdout
    mov ecx, newline                ; dirección de la nueva línea
    mov edx, 1                      ; longitud del carácter
    int 0x80                        ; Interrupción para realizar la escritura

    ; Salir
    mov eax, 1                      ; syscall: sys_exit
    xor ebx, ebx                    ; código de salida 0
    int 0x80                        ; Interrupción para terminar el programa
