    processor 6502

    seg code
    org $F000    ; Define the code origin at $F000
    
Start:
    sei          ; Disable interrupts    
    cld          ; Disable the BCD decimal math mode
    ldx #$FF     ; Loads the X register with literal #$FF
    txs          ; Transfer(tx) the X register to the (S)tack pointer

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Clear the Page Zero region ($00 to $FF)
; i.e. the entire RAM and also the entire TIA registers
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;s
    lda #0       ; A = 0
    ldx #$FF     ; x = #$FF
MemLoop:
    sta $0,X     ; Store the value of A inside of memAddr $0 + X
    dex          ; x--
    bne MemLoop  ; x != 0 ? MemLoop : -
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Fill the ROM size tp 4KB
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    org $FFFC
    .word Start  ; Reset vector at $FFFC (where the program starts)
    .word Start  ; Interrupt vector at $FFFE