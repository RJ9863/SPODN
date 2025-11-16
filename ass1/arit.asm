arit	START	0
first   LDA		x
		ADD		y
        STA		sum
        LDA		x
		SUB		y
		STA		diff
		LDA		x
		MUL		y
		STA		prod
		LDA		x
		DIV		y
		STA		quot
		MUL		y
		STA		mod
		LDA		x
		SUB		mod
		STA		mod
halt	J      	halt
. data
. inputs
x       WORD   	12
y		WORD	5
. results
sum		WORD	0
diff	WORD	0
prod	WORD	0
quot	WORD	0
mod		WORD	0
		END    	first