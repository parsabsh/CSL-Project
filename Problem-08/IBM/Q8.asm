Q8           START         0
             STM           14,12,12(13)
             BALR          12,0
             USING         *,12
             XR            1,1
             LA            3,2
             ST            3,TWO
             XR            3,3
READ         READCARD      INPUT,EOF
             CONVERTI      2,INPUT
             ST            2,N(3)
             LA            3,4(0,3)
             LA            1,1(0,1)
             B             READ
EOF          XR            9,9  USE AS I
             XR            2,2  USE AS J
             XR            3,3  USE AS INDEX
LOOP         L             4,M
             LR            7,9
             XR            6,6
             MR            6,4
             LR            3,7
             AR            3,2
             LA            5,4
             XR            4,4
             MR            4,3 STORE 4*(I*M + J) IN R5
             LR            3,5
             ST            3,POS
             L             7,ARR(3)
             ST            7,NUM
             XR            6,6
             LA            3,2
             D             6,TWO CALCULATE A[I][J]%2 IN R6
             ST            6,NUMBER
             XR            6,6
             LR            7,2
             AR            7,9
             D             6,TWO
             ST            6,PLACE
             L             7,NUMBER
             CR            6,7
             BE            CONTINUE
             L             7,NUM
             LA            7,1(0,7)
             L             6,POS
             ST            7,ARR(6)
CONTINUE     LA            2,1(0,2)
             L             3,M
             CR            2,3
             BNE           LOOP
             XR            2,2
             LA            9,1(0,9)
             L             3,N
             CR            9,3
             WTO           'ITS A HERE'
             BNE           LOOP
             WTO           'OUTPUT MATRIX: '
             XR            6,6
             L             7,N
             L             8,M
             MR            6,8
             ST            7,SIZE
             XR            2,2
             XR            3,3
PRINT        L             4,ARR(3)
             PRINTOUT      4,HEADER=NO
             LA            3,4(0,3)
             LA            2,1(0,2)
             L             4,SIZE
             CR            2,4
             BNE           PRINT
* END OF PROGRAM *
             LM            14,12,12(13)
             BR            14
* VARIABLES *
N            DS            F
M            DS            F
ARR          DS            100F
SIZE         DS            F
TWO          DS            F
PLACE        DS            F
NUMBER       DS            F
NUM          DS            F
POS          DS            F
A            DC            F'0'
INPUT        DC            CL80' '
             END           Q8
