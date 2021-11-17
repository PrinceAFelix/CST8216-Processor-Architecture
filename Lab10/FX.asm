;FX.asm
;
;Author:                P.A. Felix
;Student Number:        040933287
;Date:                  26 Mar 2021
;
;Purpose:
;
        	org     $1010    				;Origin for Program Data
X_Values	db	$0, $1, $2, $3, $4, $5, $6, $7, $8, $9            ;Staring address of Marks
EndXValues

                						;Ending address of Marks
; Expected Result

 ;Equation: f(X) = 3x + 5
                ;x = 0 to 9
 
;                   05 08 0b 0e 11 14 17 1d 20

        	org     $1020           			;Starting address of Tally
Fx   		ds      EndXValues-X_Values  			;Free Memory for Tally

        	org     $2000           			;Starting address of this program
        	lds     #$2000                                  ;Stack Location
        	ldx     #X_Values      				;Pointer to Grades
        	ldy     #Fx           				;Pointer to Store
Loop    	ldaa    1,x+             			;Get a Grade
                ldab    #$3                                     ;Get the X values
		mul	a,b                                     ;Multiply a to b
                addb    #$5                                     ;Add5 to b
                stab    1,y+                                    ;Results Store here
        	cpx     #EndXValues      			;compare x to EndGrades
        	bne     Loop             			;Not equal, go to Loop
        	swi                      			;Yes
        	end
