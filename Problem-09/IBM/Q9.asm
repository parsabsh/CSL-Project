Q2        START      0
          STM        14,12,12(13)
          BALR       12,0
          USING      *,12
          SR         1,1
          SR         3,3
          ST         3,RESULT
*   MAIN CODE    *
READ      READCARD   INPUT,EOF
          LA         1,1(0,1)
*********************************
          XR          3,3
		  XR          4,4
          XR          5,5
		  LA          6,2
		  LA          7,INPUT

LOOPF     LA         4,1(0,3)
	  
LOOPS
		  CLI        INPUT(3),C'('
		  BNE        NOCHANGE
		  CLI        INPUT(4),C')'
	      BNE        NOCHANGE
		  AR         5,6
		  MVI        INPUT(3),C'*'
		  MVI        INPUT(4),C'*'
NOCHANGE
		  LA         4,1(0,4)
		  CLI        INPUT(4),C'$'
	      BNE        LOOPS

		  LA         3,1(0,3)
		  CLI        INPUT(3),C'$'
	      BNE        LOOPS

***********************************
		  XR          4,4
FOR_PRINT 
		  CLI        INPUT(4),C'$'
	      BE         BREAK_PRINT
		  CLI        INPUT(4),C'*'
		  BNE        NOPRINT
		  LA         4,1(0,4)
		  OUTPRINT   4,HEADER=NO
		  B FOR_PRINT
NOPRINT   
          LA         4,1(0,4)
		  B          FOR_PRINT
BREAK_PRINT
EOF		  
FN        DS         F
N         DS         F
ARR       DS         100F
RESULT    DS         F
A         DC         F'0'
INPUT     DC         CL80' '
MSG       DC         C'COUNTS OF EDGES= '
          END        Q2
