section .data
    msg db "Resultado:", 0          ; Mensaje a imprimir seguido de un terminador nulo

section .bss
    buffer resb 1                   ; Reservar 1 byte para almacenar el carácter ASCII

section .text
    global _start                   ; Declarar el punto de entrada global

_start:
    ; Imprimir el mensaje
    mov eax, 4                      ; syscall: sys_write
    mov ebx, 1                      ; file descriptor: stdout (salida estándar)
    mov ecx, msg                    ; puntero al mensaje
    mov edx, 10                     ; longitud del mensaje a imprimir
    int 0x80                        ; Llamar al kernel para realizar la escritura

    ; Imprimir el carácter '0' usando modo inmediato
    mov eax, 4                      ; syscall: sys_write
    mov ebx, 1                      ; file descriptor: stdout (salida estándar)
    mov ecx, buffer                 ; puntero a un buffer temporal
    mov byte [ecx], '0'             ; Almacenar el carácter '0' en el buffer
    mov edx, 1                      ; Imprimir 1 byte
    int 0x80                        ; Llamar al kernel para realizar la escritura

    ; Salir
    mov eax, 1                      ; syscall: sys_exit
    xor ebx, ebx                    ; establecer el estado de salida a 0
    int 0x80                        ; Llamar al kernel para salir
