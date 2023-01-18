**************************************************
*                                                *
*            PROBLEM 01 - CSL Project            *
*                                                *
**************************************************
* START THE PROGRAM AND INIT BASE REGISTER
PR01        START       0
            STM         14,12,12(13)
            BALR        12,0
            USING       *,12
* MAIN PROGRAM
            SR          3,3                 KEEP THE SUM IN R3
            SR          1,1                 INPUT LINE COUNTER
READ        READCARD    CARDOUT,EOF         READ THE INPUT TILL THE END
            LA          1,1(0,1)            COUNTER INCREMENT
            CONVERTI    2,CARDOUT           CONVERT CHARS TO NUMBER
            AR          3,2                 ADD READ NUMBER TO R3
            B           READ                GET NEXT INPUT
EOF         PRINTLIN    MSG,20              PRINT MSG
            PRINTOUT    3,HEADER=NO         PRINT THE RESULT WITH NO HEADER
* RETURN TO OS
            LM          14,12,12(13)
            BR          14
SAVEAREA    DS          18F
CARDOUT     DC          CL80' '
MSG         DC          C' SUM OF INPUTS = '
            END         PR01