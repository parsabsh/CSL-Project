*********************************
*				*
*    Problem 4 - CSL Project    *
*				*
*********************************
* REGISTER USES:
PROG4		START		0
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
		END		PROG4