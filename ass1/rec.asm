rec		START	0
init	LDX		#0
startn	JSUB	readc	; read first char
		COMP	zero
		JEQ		halt
		COMP	cret
		JEQ		startn	; ignore CR
		COMP	lfd
		JEQ		startn	; ignore LF
		SUB		zero
		STA		sum
starti	JSUB	readc	; read chars until CR char
		COMP	cret
		JEQ		fact
		SUB		zero
		LDS		sum
		LDT		#10
		MULR	T,S
		ADDR	S,A
		STA		sum
		J		starti
		
fact	LDA		sum		; Handle line
		JSUB	factl	; compute factorial
		JSUB	print	; print result
		LDA		lfd
		JSUB	printc	; print LF char
		LDA		cret
		JSUB	printc	; print CR char
		J		startn	; read next line
		
factl	COMP	#1		; compute factorial of a
		JEQ		fret1
		COMP	#0
		JEQ		fret1
		LDS		#0
		ADDR	A,S		; a -> s
		SUB		#1		; a <- a-1
		
		STA		asave
		LDA		#3
		STS		STACK,X
		ADDR	A,X
		STT		STACK,X
		ADDR	A,X
		STL		STACK,X
		ADDR	A,X
		LDA		asave
		
		JSUB	factl	; a <- f(n-1)
		
		STA		asave
		LDA		#3
		SUBR	A,X
		LDL		STACK,X
		SUBR	A,X
		LDT		STACK,X
		SUBR	A,X
		LDS		STACK,X
		LDA		asave
		
		MULR	S,A		; a <- f(n-1) * f(n)
		RSUB
fret1	LDA		#1
		RSUB
		
halt	J      	halt
retlbl	RSUB
readc	LDA		#0	
		TD		devin
		JEQ		readc
		RD		devin
		RSUB
		
print	LDS		#0
		LDT		#0
		ADDR	A, S	; a -> S
		ADDR	A, T	; a -> T
		LDB		#10
		DIVR	B, S
		MULR	B, S
		SUBR	S, T	; t = a%10
		DIVR	B, S	; s = a/10
		LDA		#0
		ADDR	S,A		; a = a/10
		COMP	#0
		JEQ		endp
		
		STA		asave
		LDA		#3
		STS		STACK,X
		ADDR	A,X
		STT		STACK,X
		ADDR	A,X
		STL		STACK,X
		ADDR	A,X
		LDA		asave
		
		JSUB	print
		
		STA		asave
		LDA		#3
		SUBR	A,X
		LDL		STACK,X
		SUBR	A,X
		LDT		STACK,X
		SUBR	A,X
		LDS		STACK,X
		LDA		asave
		
endp	LDA		#0x30
		ADDR	T, A
printc	TD		stdout
		JEQ		printc
		WD		stdout
		RSUB

		
. data
asave	WORD	0
STACK	RESW	100
sum		WORD	0
devin	BYTE	0xFA
stdout	BYTE	0x01
zero	WORD	0x30
null	WORD	0x00
cret	WORD	0x0D
lfd		WORD	0x0A
		END    	init