*********************************
*				*
*    Problem 4 - CSL Project    *
*				*
*********************************
PRO1		START		0
		STM		14,12,12(13)
		BALR		12,0
		USING		*,12
		XR		1,1
		READCARD	INPUT,EOF
		CONVERTI	2,INPUT
		ST		2,N
		LR		4,2
		LA		4,1(0,4)	R4 = N + 1
		LA		3,0		INDEX
		LA		1,1		LINE TO BE READ
INPUTCOEF	READCARD	INPUT,EOF
		CONVERTI	2,INPUT
		ST		2,COEF(3)
		LA		1,1(0,1)
		LA		3,4(0,3)	R3 += 4
		BCT		4,INPUTCOEF	N+1 TIMES
		READCARD	INPUT,EOF
		CONVERTI	2,INPUT
		C		2,=F'1'
		BE		INTEGRAL
*************************
*    DIFFERENTIATION    *
*************************				
		XR		3,3
		L		2,N
DIFLOOP		L		5,COEF(3)
		MR		4,2		R4:R5 = R5 * R2
		PRINTOUT	5,HEADER=NO
		LA		3,4(0,3)	R3 += 4
		BCT		2,DIFLOOP
		B		EOF
*************************
*      INTEGRATION      *
*************************
INTEGRAL	XR		3,3
		L		2,N
		LA		2,1(0,2)	R2 = N + 1
INTLOOP		L		5,COEF(3)
		XR		4,4
		DR		4,2		R5 = R4:R5 / R2
		PRINTOUT	5,HEADER=NO
		LA		3,4(0,3)	R3 += 4
		BCT		2,INTLOOP
		WTO		'C'
* RETURN TO OS
EOF		LM 		14,12,12(13)
		BR		14
* VARIABLES
INPUT     	DC		CL80' '
N		DC		F'0'
COEF		DC		100F'0'
		END		PR01