*********************************
*				*
*    Problem 7 - CSL Project    *
*				*
*********************************
* REGISTER USES:
* R2 = N
* R3,R4,R5 = TEMP
* R6 = RETURN ADDRESS
* R7 = NUMBER - A
* R10 = NUMBER
* R11 = A
PROG7		START		0
		STM		14,12,12(13)
		BALR		12,0
		USING		*,12
		XR		1,1
		READCARD	INPUT,EOF

* RETURN TO OS
EOF		LM 		14,12,12(13)
		BR		14
* VARIABLES
FIRSTUNPCKD	DC		CL80' '
SECONDUNPACKD	DC		CL80' '
FIRSTPACKD	DC		CL80' '
SECONDPACKD	DC		CL80' '
OPERATOR	DC		CL80' '