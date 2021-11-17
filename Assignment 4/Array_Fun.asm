; Array_Fun.asm
; Author: D. Haley, Faculty, 2 Apr 2021
;
; Student Name(s): Prince Adrianne Felix
; Student Number(s): 040933287
; Modification Date:  APril 15, 2021
;
;
; Purpose:      The purpose of this program is to gain further experience with
;               the use of Arrays in 68HCS12 Assembly Language by performing
;               the following Tasks:
;
;               a. Determine the Maximum value in the Array and store the
;                  value at Max
;               b. Determine the Mimumum value in the Array and store the
;                  value at Min
;               c. Using the value stored at Max, determine how often that
;                  value occurs in the Array and store that value at NumMax
;               d. Using the value stored at Min, determine how often that
;                  value occurs in the Array and store that value at NumMin
;               e. Range tells how far apart the Max and Min numbers are in a set
;                  It is the positive difference between the two values
;                  Using the values in NumMax and NumMin, subtract those two
;                  values a store the result at Range
;               f. MidRange is the Average of the Range - e.g. Range / 2
;                  Using the Values of Range and DIVISOR, calculate the
;                  MidRange using idiv (mandatory) and store an 8-bit version of
;                  the Answer at MidRange and an 8-bit version of the Reminder
;                  at MidRange + 1
;               g. Display NumMax and NumMin on the two left-most HEX Displays
;                  (like you did with the BCD Counter), alternating their
;                  displayed values every 250 ms.
;                  NOTE: API.s19 must be loaded in order for this feature
;               h. Code must run correctly for more than one program run
;                  e.g. File -> Reset, the GO on Simulator must give same results

; --- Do Not Change Code marker ---
; Library Routines used in this software
;
Config_Hex_Displays         equ        $2117
Delay_Ms                    equ        $211F
Hex_Display                 equ        $2139

                                ; Port P (PPT) Display Selection Values
DIGIT3_PP0      equ     %1110   ; Left-most display MSB
DIGIT2_PP1      equ     %1101   ; 2nd from left-most display LSB

; Delay Subroutine Values
DVALUE  equ     #250            ; Delay value (base 10) 0 - 255 ms
                                ; 125 = 1/8 second <- good for Dragon12 Board

DIVISOR equ     $02

        org     $1000
Array
#include 21W_Array.txt
EndArray

        org     $1020
Max     ds      1
Min     ds      1

        org     $1030
NumMax  ds      1
NumMin  ds      1

        org     $1040
Range           ds      1
MidRange        ds      2

; --- End of Do Not Change Code marker ---

        org     $2000
        lds     #$2000
; your code goes here

;Calculate the Max Number in the Array
        ldx      #Array                 ;Load x with Array
Loop    MAXA        1,x+                    ;Get the Min of the array
        staa    Max                     ;Store a at location Max
        cpx     #EndArray               ;Compare the end of array
        bne     Loop                    ;Loop again if not equal
;Calculate the Min Number in the Array
        ldx     #Array                  ;Load x with Array
Loop2   MINA        1,x+                    ;Get the Min of the array
        staa    Min                     ;Store a at location Min
        cpx     #EndArray               ;Compare the end of array
        bne     Loop2                   ;Loop again if not equal

;Count how many times the Max value appear
        ldx     #Array                  ;Load x with Array
        ldab    $0                      ;Load b with 0
        stab    NumMax                  ;store the value of b in NumMax
Loop3   ldaa    1,x+                    ;Load a with first index in array, increment address at x
        cmpa    Max                     ;Compare Max
        bne     cEnd                    ;Branh if not equal to cEnd2
        inc     NumMax                  ;Increment the value at NumMax
        bra     cEnd                    ;Branh always to cEnd2

cEnd    cpx     #EndArray               ;Compare the end of array
        bne     Loop3                   ;Loop again if not equal
        
;Count how many times the Min value appear
        ldx     #Array                  ;Load x with Array
        ldab    $0                      ;Load b with 0
        stab    NumMin                  ;store the value of b in NumMin
Loop4   ldaa    1,x+                    ;Load a with first index in array, increment address at x
        cmpa    Min                     ;Compare Min
        bne     cEnd2                   ;Branh if not equal to cEnd2
        inc     NumMin                  ;Increment the value at NumMin
        bra     cEnd2                   ;Branh always to cEnd2
        
cEnd2   cpx     #EndArray               ;Compare the end of array
        bne     Loop4                   ;Loop again if not equal

;Calculate the Range (Max-Min)
        ldaa    Max                     ;Load a with the Max Value
        suba    Min                     ;Subtrcat a to Min
        staa    Range                   ;Store the Range at Range Address

;Calculate the Midrange (Range / 2)
        ldab     Range                  ;Load b with the Range
        ldx     #DIVISOR                ;Load x with the divide value
        idiv                            ;Divide Integer
        stx     MidRange                ;Store Quotient at MidRange
        stab    MidRange+1              ;Store Remainder at MidRange+1

;Display the NumMax and NumMin
        jsr     Config_Hex_Displays     ;Use the Hex Displays to display the count
Loop5   ldaa    NumMax
        psha                           ;Store A onto the stack
        ldab    #DIGIT3_PP0            ;left most display msb
        jsr     Hex_Display            ;Jump to subroutine Hex Display
        ldaa    #DVALUE                ;Load a with Delay Value
        jsr     Delay_ms               ;Delay the counter by ms

        ldaa    NumMin                 ;Load the return address
        ldab    #DIGIT2_PP1            ;Load B with 2nd LSB
        jsr     Hex_Display            ;Jump to subroutine Hex Display
        ldaa    #DVALUE                ;Load a with Delay Value
        jsr     Delay_ms               ;Delay the counter by ms

        pula                           ;Pull a from the stack
        bra     Loop5                  ;Do the count again
        
        swi
        end



        
        
        
        
        