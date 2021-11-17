;GradesII.asm
;
;Author:                P.A. Felix
;Student Number:        040933287
;Date:                  25 Mar 2021
;
;Purpose:               Count the number a Given marks Occur in the Array
;
        org     $1020    ;Origin for Program Data
Grades                   ;Staring address of Marks
#include Grades.txt      ;Include the text file
EndGrades                ;Ending address of Marks
; Expected Result

;               $103A $103B $103C $103D $103E $103F
;                   5     3     2     3   N/A     3

        org     $1030           ;Starting address of Tally
Store   ds      EndGrades-Grades  ;Free Memory for Tally

        org     $2000           ;Starting address of this program
        lds     #$2000
        ldx     #Grades          ;Pointer to Grades
        ldy     #Store           ;Pointer to Store
Loop    ldaa    1,x+             ;Get a Grade
        ldab    #$37             ;Load B with 37
		sba                      ;Subtract B to A
		inc     a,y              ;Increment a at memory address y
		cpx     #EndGrades       ;compare x to EndGrades
        bne     Loop             ;Not equal, go to Loop
        swi                      ;Yes
        end

