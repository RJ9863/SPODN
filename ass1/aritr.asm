aritr	START	0
first   LDA		#0
		LDS		x
		LDT		y
		
		ADDR	S,A
		ADDR	T,A
        STA		sum
		
		LDA		#0
		ADDR	S,A
		SUBR	T,A
		STA		diff
		
		LDA		#0
		ADDR	S,A
		MULR	T,A
		STA		prod
		
		LDA		#0
		ADDR	S,A
		DIVR	T,A
		STA		quot
		
		MULR	A,T
		SUBR	T,S
		STS		mod
halt	J      	halt
. data
. inputs
x       WORD   	17
y		WORD	5
. results
sum		WORD	0
diff	WORD	0
prod	WORD	0
quot	WORD	0
mod		WORD	0
		END    	first