; Exam.asm
; Author:               Prince Adrianne Felix
; Student Number(s):    040933287
; Course:               CST8216 Winter 2021
; Date:                 April 21, 2021
;
; Purpose       The purpose of this program is to count those results that have Remainder = 0
;
;               TEST PLAN:
;                   1)Reserved a memory for the total count and Remainder
;                   2)Load Org and Stack Address
;                   3)Read All Array
;                   4)IF element/value is not "0", do the devision, else Keep Looping
;                   5)Store the remainder in Reserved Address
;                   6)Check if Equal to "0", increment if equal, else check if end of array
; --------------------------------------------------------------------------------------------------

DIVISOR equ     $0      ;Divisor

        org     $1000   ;Array
Array
	db      183,132,245,252,76,140,182,0,14,154,168,56,22,0,28,238,42,238,184,196
EndArray

        org     $1020  ;Result of count
Result  ds      1

        org     $1030   ;Remainder
Rem     ds      1


        org     $2000
        lds     #$2000

        ldx     #Array   ;Load x with Array
        ldab    $0       ;Load b with 0
        stab    Result   ;Store b at Result address
Loop    stab    Rem      ;Store b at Rem, so it always set Rem to 0
	ldaa    1,x+     ;Load a with first index in array, increment address at x
        cmpa    #$0      ;Check if 0
        bne     Divide   ;Branch to Divide if not equal
        bra     cEnd     ;Check the end array

Divide  ldy     #DIVISOR ;Load y with the Divisor
        idiv             ;Do the Division
        staa    Rem      ;Store the remainder
        ldab    Rem      ;Load b with Remainder
        cmpa    #$0      ;Check if eaul to 0
        bne     cEnd     ;If not equal check for the end array
        inc     Result   ;Icrement Result if there's no Remainder
        bra     cEnd     ;BRanch Always Check end
        
cEnd    cpx     #EndArray ;Check the end of array
        bne     Loop      ;Loop again if not end of array
        
        swi
        end
        

        