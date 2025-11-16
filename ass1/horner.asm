horner	START	0
first	LDX		curdeg
		LDA		#3
		MULR	A,X
		LDB		cofs,X
		LDA 	sum
		MUL		num
		ADDR	B,A
		STA		sum
		LDA 	curdeg
		COMP	#0
		JEQ		halt
		SUB		#1
		STA		curdeg
		J		first
halt	J      	halt
. data
. inputs
curdeg	WORD	4
maxdeg	WORD	4
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