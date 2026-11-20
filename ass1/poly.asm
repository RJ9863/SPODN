poly	START	0
first	LDX		curdeg
		LDA		#3
		MULR	A,X
		LDA		cofs,X
		MUL		xton
		ADD		sum
		STA		sum
		LDA		xton
		MUL		num
		STA		xton
		LDA 	curdeg
		ADD		#1
		STA		curdeg
		LDA		maxdeg
		COMP	curdeg
		JLT		halt
		J		first
halt	J      	halt
. data
. inputs
curdeg	WORD	0
maxdeg	WORD	4
xton	WORD	1
sum		WORD	0
num		WORD	2
cofs    WORD   	5
		WORD   	4
		WORD   	3
		WORD	2
		WORD	1
. results
eval	WORD	0
		END    	first