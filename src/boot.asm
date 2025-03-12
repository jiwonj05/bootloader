[BITS 16]
[ORG 0x7C00]

start:
    cli                 ; Clear interrupts
    xor ax, ax          ; Set AX = 0
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00      ; Set stack pointer
    sti                 ; Enable interrupts

    mov si, msg         ; Load message address

print:
    lodsb               ; Load byte at DS:SI into AL and increment SI
    cmp al, 0           ; Check if null terminator
    je done             ; If so, stop
    mov ah, 0x0E        ; BIOS teletype function
    int 0x10            ; Print character in AL
    jmp print           ; Repeat

done:
    cli
    hlt                 ; Halt CPU

msg: db 'Hello World!', 0  ; Message to print

times 510-($-$$) db 0      ; Pad to 510 bytes
dw 0xAA55                 ; Boot signature
