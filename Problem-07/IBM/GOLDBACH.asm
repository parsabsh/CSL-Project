*******************************
*							  *
*   Problem 7 - CSL Project   *
*							  *
*******************************
PROB7		START		0
			STM			14,12,12(13)
			BALR		12,0
			USING		*,12
			LA			1,1				ONLY ONE LINE INPUT
			READCARD	INPUT
			CONVERTI	2,INPUT
			ST			2,N
			
		
		
ISPRIME			
* RETURN TO OS
		LM 			14,12,12(13)
		BR			14
* VARIABLES		
N		DC			F'0'
INPUT	DC  		CL10' '
EQUAL	DC 			C'='
PLUS	DC			C'+'
NEWL	DC			X'15'
		END 		PROB7