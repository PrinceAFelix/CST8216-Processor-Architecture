;Grades.asm
;
;Author:                P.A. Felix
;Student Number:        040933287
;Date:                  16 Mar 2021
;
;Purpose:               Assign a letter grade to specific marks
;
EIGHTY  equ     80      ;Grades For 80
SEVENTY equ     70      ;Grades For 70
SIXTY   equ     60      ;Grades For 60
FIFTY   equ     50      ;Grades For 50

        org     $1000   ; Origin for Program Data
Marks                   ;Staring address of Marks
#include Marks.txt      ;Include the text file
EndMarks                ;Ending address of Marks
; Expected Result
;               A B D C F F A F D A A A A F D B

        org     $1020           ;Starting address of letter grade
Store   ds      EndMarks-Marks  ;Allocate memory for the letter grade

        org     $2000           ;Starting address of this program
        lds     #$2000
        ldx     #Marks          ;Pointer to the start of the array
        ldy     #Store           ;Pointer to the allocated memory space
Loop    ldaa    1,x+            ;Load a with the first element in the array, with post increment
Check80 cmpa    #EIGHTY         ;Compare a to 80
        bhs     AssignA         ;If higher, Assign A
Check70 cmpa    #SEVENTY        ;Compare a to 70
        bhs     AssignB         ;If higher, Assign B
Check60 cmpa    #SIXTY          ;Compare a to 60
        bhs     AssignC         ;If higher, Assign C
Fgrade  cmpa    #FIFTY          ;Compare a to 50
        bhs     AssignD         ;If higher, Assign D
        blo     AssignF         ;If Lower, Assign F
        
AssignA ldab    #'A'            ;Label, for assigning A
        bra     Next            ;Go to Label Next
AssignB ldab    #'B'            ;Label, for assigning B
        bra     Next            ;Go to Label Next
AssignC ldab    #'C'            ;Label, for assigning C
        bra     Next            ;Go to Label Next
AssignD ldab    #'D'            ;Label, for assigning D
        bra     Next            ;Go to Label Next
AssignF ldab    #'F'            ;Label, for assigning F

Next    stab    1,y+            ;Store the letter grade to the alloctaed memory
        cpx     #EndMarks       ;compare x, if the end of array
        bne     Loop            ;No, loop again
        swi                     ;Yes
        end