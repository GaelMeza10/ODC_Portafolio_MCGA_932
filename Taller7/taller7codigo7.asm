section .data
    msg db 'Resultado:', 0      ; Mensaje a imprimir seguido de un terminador nulo
    character db '@'            ; Almacenar el carácter '@'

section .text
    global _start               ; Declarar el punto de entrada global

_start:
    ; Imprimir el mensaje
    mov eax, 4                  ; syscall: sys_write
    mov ebx, 1                  ; File descriptor: stdout (salida estándar)
    mov ecx, msg                ; Puntero al mensaje
    mov edx, 10                 ; Longitud del mensaje a imprimir
    int 0x80                    ; Llamar al kernel para realizar la escritura

    ; Imprimir el carácter '@' usando modo indirecto
    mov eax, 4                  ; syscall: sys_write
    mov ebx, 1                  ; File descriptor: stdout (salida estándar)
    mov ecx, character          ; Puntero a la variable que contiene '@'
    mov edx, 1                  ; Imprimir 1 byte
    int 0x80                    ; Llamar al kernel para realizar la escritura

    ; Salir
    mov eax, 1                  ; syscall: sys_exit
    xor ebx, ebx                ; Establecer el estado de salida a 0
    int 0x80                    ; Llamar al kernel para salir
