section .data
    message db "Contando: ", 0
    newline db 10, 0

section .bss
    count resb 1

section .text
    global _start

_start:
    ; Inicializar el contador con un valor inicial (por ejemplo, 9)
    mov byte [count], 9

countdown:
    ; Imprimir el mensaje "Contando: "
    mov rax, 1            ; syscall: write
    mov rdi, 1            ; file descriptor: stdout
    mov rsi, message      ; dirección del mensaje
    mov rdx, 10           ; longitud del mensaje
    syscall

    ; Imprimir el valor actual del contador
    mov al, [count]       ; cargar el valor del contador en AL
    add al, '0'           ; convertir a carácter ASCII
    mov rsi, rsp          ; usar el stack para el carácter
    mov byte [rsi], al    ; almacenar el carácter
    mov rdx, 1            ; longitud del carácter
    mov rdi, 1            ; stdout
    mov rax, 1            ; syscall: write
    syscall

    ; Imprimir una nueva línea
    mov rax, 1            ; syscall: write
    mov rdi, 1            ; file descriptor: stdout
    mov rsi, newline      ; dirección del salto de línea
    mov rdx, 1            ; longitud del salto de línea
    syscall

    ; Decrementar el contador
    mov al, [count]
    dec al
    mov [count], al

    ; Verificar si el contador llegó a -1 (para salir)
    cmp al, -1
    jz exit_program       ; Saltar si el contador es -1

    ; Continuar el conteo
    jmp countdown

exit_program:
    ; Finalizar el programa
    mov rax, 60           ; syscall: exit
    xor rdi, rdi          ; código de salida: 0
    syscall
