Q2        START      0
          STM        14,12,12(13)
          BALR       12,0
          USING      *,12
          SR         1,1
          SR         3,3
          ST         3,RESULT
*   MAIN CODE    *
READ      READCARD   INPUT,EOF
          CONVERTI   2,INPUT
          LA         1,1(0,1)
          ST         2,N(3)
          LA         3,4(0,3)
          B          READ
EOF       LA         4,4
          SR         3,4
          ST         3,FN
          XR         3,3
          XR         2,2
LOOP      L          7,ARR(3)
          L          10,ARR(2)
          LR         4,10
          SR         4,7
          LA         5,1
          CR         5,4
          BNE        CONTINUE
          L          5,RESULT
          LA         5,1(0,5)
          ST         5,RESULT
CONTINUE  LA         2,4(0,2)
          L          5,FN
          CR         2,5
          BL         LOOP
          XR         2,2
          LA         3,4(0,3)
          L          5,FN
          CR         3,5
          BL         LOOP
          PRINTLIN   MSG,20
          L          3,RESULT
          PRINTOUT   3,HEADER=NO
          LM         14,12,12(13)
          BR         14
FN        DS         F
N         DS         F
ARR       DS         100F
RESULT    DS         F
A         DC         F'0'
INPUT     DC         CL80' '
MSG       DC         C'COUNTS OF EDGES= '
          END        Q2
