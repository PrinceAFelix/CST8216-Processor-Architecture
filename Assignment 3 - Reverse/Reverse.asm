; Reverse.asm
; Author:               D. Haley, Faculty
; Modified by:          Prince Adrianne Felix
; Student Number(s):    040933287
; Course:               CST8216 Winter 2021
; Date:                 April 3, 2021
;
; Purpose       To copy and reverse and array, while performing the following
;               additional operations to decrypt the Secret Message. After
;               reading in a value, we decrypt the value by
;                a. dividing the value by 3
;               b. then adding 32 to the value
;               c. storing the value

; Decryption Constants
DIVISOR         equ     3       ; Value in supplied array will be divided by
                                ; this value
ADDED_VALUE     equ     32      ; Divided value will have 32 added to it

                org     $1000
Source_Array
#include A3B_Array.txt
End_Source_Array
                org        $1020                        ; Secret Message will appear
                                                        ; starting here
Destination_Array
                ds      End_Source_Array-Source_Array   ; auto calculate Array Size
End_Destination_Array

                org     $2000
                lds     #$2000                  ;Initialize Stack
                ldx     #Source_Array           ;Point to start of the source array
		ldy     #End_Destination_Array  ;Point to end destination array
Loop            ldab    1,x+                    ;Load b with first element of array
                
                pshx                            ;push x to the stack
                ldx     #DIVISOR                ;Load x with DIVISOR
                idiv                            ;Divide integer
                exg     x,b                     ;Exchange x to b
                addb    #ADDED_VALUE            ;Add to B
                pulx                            ;Pull x from stack
                stab    1,y-                    ;Store the value
                cpx     #End_Source_Array       ;Compare x
                bne     Loop                    ;No, loop again
                end