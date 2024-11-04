org 0x7c00
bits 16

%define ENDL 0x0D, 0x0A

start:
    jmp main

; Prints a string to the screen.
; Params:
;   - ds:si points to the string

puts:
    ; save registers we will modify
    push si
    push ax

.loop:
    lodsb   ; load next character in al
    or al, al   ; verify if next character is nul
    jz .done

    mov ah, 0x0e ; call BIOS interrupt
    mov bh, 0
    int 0x10

    jmp .loop

.done:
    pop bx
    pop ax
    pop si
    ret

main:

    ; setup data segment
    mov ax, 0 ; can't write to ds/es directly
    mov ds, ax
    mov es, ax

    ; setup stack
    mov ss, ax
    mov sp, 0x7C00 ; stack grows downward from where we are loaded in memory

    ;   print message
    mov si, hello_msg
    call puts

    hlt

.halt:
    jmp .halt

hello_msg: db 'Hello World!', ENDL, 0

times 510-($-$$) db 0
dw 0AA55h