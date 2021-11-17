; BCD_Counter.asm
; Author:               D. Haley, Faculty
; Modified by:          Prince Adrianne Felix
; Student Number(s):    040933287
; Course:               CST8216 Winter 2021
; Date:                 April 3, 2021
;
; Purpose       BCD Counter $00 - $15 (BCD) using Hex Displays
;               and a single register, Accumulator A, for the count
;               The range of counting can be altered by changing the
;               FIRST_BCD and END_BCD constants
;
; ***** DO NOT CHANGE ANY CODE BETWEEN THESE MARKERS *****
; Library Routines  - to be used in your solution
;

Config_Hex_Displays         equ        $2117
Delay_Ms                    equ        $211F
Hex_Display                 equ        $2139
Extract_Msb                 equ        $2144
Extract_Lsb                 equ        $2149

; Program Constants - to be used in your solution
STACK           equ     $2000
                                ; Port P (PPT) Display Selection Values
DIGIT3_PP0      equ     %1110   ; Left-most display MSB
DIGIT2_PP1      equ     %1101   ; 2nd from left-most display LSB

; Delay Subroutine Value  - to be used in your solution
DVALUE  equ     #250            ; Delay value (base 10) 0 - 255 ms
                                ; 125 = 1/8 second <- good for Dragon12 Board

; ***** END OF DO NOT CHANGE ANY CODE BETWEEN THESE MARKERS *****

; BCD Count constants  - to be used in your solution
; Changing these values will change the Starting and End BCD counts

FIRST_BCD        equ     $00     ; Starting BCD count
END_BCD          equ     $15     ; Ending BCD count0

        org     $2000
Start   lds     #STACK          ; Initialize the Stack

        jsr     Config_HEX_Displays ; Use the Hex Displays to display the count
; Continually Count FIRST_BCD ... END_BCD ... FIRST_BCD ... END_BCD
Count   ldaa    #FIRST_BCD              ;counter start at 0

Loop    psha                           ;Store A onto the stack
        jsr     Extract_Msb            ;Jump to subroutine MSB
        ldab    #DIGIT3_PP0            ;left most display msb
        jsr     Hex_Display            ;Jump to subroutine Hex Display
        ldaa    #DVALUE                ;Load a with Delay Value
        jsr     Delay_ms               ;Delay the counter by ms

        ldaa    0,sp                   ;Load the return address
        jsr     Extract_Lsb            ;Jump to subroutine LSB
        ldab    #DIGIT2_PP1            ;Load B with 2nd LSB
        jsr     Hex_Display            ;Jump to subroutine Hex Display
        ldaa    #DVALUE                ;Load a with Delay Value
        jsr     Delay_ms               ;Delay the counter by ms

        pula                           ;Pull a from the stack
        cmpa    #END_BCD               ;Check if end bcd
        beq     Count                  ;Count again
        adda    #1                     ;Add 1 to A
        daa                            ;Adjust BCD
        bra     Loop                   ;Do the count again
        end