*********************************
*				*
*    Problem 5 - CSL Project    *
*				*
*********************************
* REGISTER USES:
* R2 = N
* R3 = INDEX
* R4,R5 = TEMP
* R6 = RETURN ADDRESS
* R7 = NUMBER
* R10 = SECOND NUMBER
* R11 = A
Q2		START		0
		STM		14,12,12(13)
		BALR		12,0
		USING		*,12
		SR		1,1	
        SR      3,3
        ST      3,RESULT MAKE RESULT = 0
*-------------------*
*   ;   MAIN    ;   *
*___________________*
READ	READCARD	INPUT,EOF 
		CONVERTI	2,INPUT
        LA      1,1(0,1)
		ST		2,N(3)
        LA      3,4(0,3) ;increase R3
        B       READ
EOF		XR      3,3 index for first number
        XR      2,2 index for second number
LOOP    L       7,ARR(3)
        L       10,ARR(2)
        LR      4,10
        SR      4,7
        LA      5,1
        CR      5,4
        BNE     CONTINUE a[i] - a[j] != 1
        L       5,RESULT
        LA      5,1(0,5)
        ST      5,RESULT
CONTINUE    LA  2,1(0,2)
        L       5,N
        CR      2,5
        BNE     LOOP
        XR      2,2
        LA      3,1(0,3)
        L       5,N
        CR      3,5
        BNE     LOOP
        PRINTLIN    MSG,20
        L       3,RESULT
        PRINTOUT    3,HEADER=NO

        LM 		14,12,12(13)
		BR		14

* VARIABLES
N		DS		F
ARR     DS      100F
RESULT  DS      F
A		DC		F'0'
INPUT		DC  		CL80' '
MSG     DC      C'  COUNT OF EDGES ='
		END 		Q2
