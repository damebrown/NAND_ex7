//push constant 17
	@17
	D=A
	@SP
	M=M+1
	A=M-1
	M=D
//push constant 17
	@17
	D=A
	@SP
	M=M+1
	A=M-1
	M=D
//eq
	@SP
	AM=M-1
	D=M
	A=A-1
	D=D-M
	@SP
	A=M-1
	M=-1
	@BOOL.OP.END.1
	D;JEQ
	@SP
	A=M-1
	M=0
(BOOL.OP.END.1)
//push constant 17
	@17
	D=A
	@SP
	M=M+1
	A=M-1
	M=D
//push constant 16
	@16
	D=A
	@SP
	M=M+1
	A=M-1
	M=D
//eq
	@SP
	AM=M-1
	D=M
	A=A-1
	D=D-M
	@SP
	A=M-1
	M=-1
	@BOOL.OP.END.2
	D;JEQ
	@SP
	A=M-1
	M=0
(BOOL.OP.END.2)
//push constant 16
	@16
	D=A
	@SP
	M=M+1
	A=M-1
	M=D
//push constant 17
	@17
	D=A
	@SP
	M=M+1
	A=M-1
	M=D
//eq
	@SP
	AM=M-1
	D=M
	A=A-1
	D=D-M
	@SP
	A=M-1
	M=-1
	@BOOL.OP.END.3
	D;JEQ
	@SP
	A=M-1
	M=0
(BOOL.OP.END.3)
//push constant 892
	@892
	D=A
	@SP
	M=M+1
	A=M-1
	M=D
//push constant 891
	@891
	D=A
	@SP
	M=M+1
	A=M-1
	M=D
//lt
	@SP
	A=M-1
	D=M
	@POSITIVE.Y.4
	D;JGE
	@SP
	A=M-1
	A=A-1
	D=M
	@REG.COMP.4
	D;JLT
	@SP
	AM=M-1
	A=A-1
	M=0
	@END.BOOL.4
	0;JMP
	@END.BOOL.4
	0;JMP
(POSITIVE.Y.4)
	@SP
	A=M-1
	A=A-1
	D=M
	@REG.COMP.4
	D;JGE
	@SP
	AM=M-1
	A=A-1
	M=-1
	@END.BOOL.4
	0;JMP
(REG.COMP.4)
	@SP
	AM=M-1
	D=M
	A=A-1
	D=D-M
	@SP
	A=M-1
	M=-1
	@END.BOOL.4
	D;JGT
	@SP
	A=M-1
	M=0
(END.BOOL.4)
//push constant 891
	@891
	D=A
	@SP
	M=M+1
	A=M-1
	M=D
//push constant 892
	@892
	D=A
	@SP
	M=M+1
	A=M-1
	M=D
//lt
	@SP
	A=M-1
	D=M
	@POSITIVE.Y.5
	D;JGE
	@SP
	A=M-1
	A=A-1
	D=M
	@REG.COMP.5
	D;JLT
	@SP
	AM=M-1
	A=A-1
	M=0
	@END.BOOL.5
	0;JMP
	@END.BOOL.5
	0;JMP
(POSITIVE.Y.5)
	@SP
	A=M-1
	A=A-1
	D=M
	@REG.COMP.5
	D;JGE
	@SP
	AM=M-1
	A=A-1
	M=-1
	@END.BOOL.5
	0;JMP
(REG.COMP.5)
	@SP
	AM=M-1
	D=M
	A=A-1
	D=D-M
	@SP
	A=M-1
	M=-1
	@END.BOOL.5
	D;JGT
	@SP
	A=M-1
	M=0
(END.BOOL.5)
//push constant 891
	@891
	D=A
	@SP
	M=M+1
	A=M-1
	M=D
//push constant 891
	@891
	D=A
	@SP
	M=M+1
	A=M-1
	M=D
//lt
	@SP
	A=M-1
	D=M
	@POSITIVE.Y.6
	D;JGE
	@SP
	A=M-1
	A=A-1
	D=M
	@REG.COMP.6
	D;JLT
	@SP
	AM=M-1
	A=A-1
	M=0
	@END.BOOL.6
	0;JMP
	@END.BOOL.6
	0;JMP
(POSITIVE.Y.6)
	@SP
	A=M-1
	A=A-1
	D=M
	@REG.COMP.6
	D;JGE
	@SP
	AM=M-1
	A=A-1
	M=-1
	@END.BOOL.6
	0;JMP
(REG.COMP.6)
	@SP
	AM=M-1
	D=M
	A=A-1
	D=D-M
	@SP
	A=M-1
	M=-1
	@END.BOOL.6
	D;JGT
	@SP
	A=M-1
	M=0
(END.BOOL.6)
//push constant 32767
	@32767
	D=A
	@SP
	M=M+1
	A=M-1
	M=D
//push constant 32766
	@32766
	D=A
	@SP
	M=M+1
	A=M-1
	M=D
//gt
	@SP
	A=M-1
	D=M
	@POSITIVE.Y.7
	D;JGE
	@SP
	A=M-1
	A=A-1
	D=M
	@REG.COMP.7
	D;JLT
	@SP
	AM=M-1
	A=A-1
	M=-1
	@END.BOOL.7
	0;JMP
	@END.BOOL.7
	0;JMP
(POSITIVE.Y.7)
	@SP
	A=M-1
	A=A-1
	D=M
	@REG.COMP.7
	D;JGE
	@SP
	AM=M-1
	A=A-1
	M=0
	@END.BOOL.7
	0;JMP
(REG.COMP.7)
	@SP
	AM=M-1
	D=M
	A=A-1
	D=D-M
	@SP
	A=M-1
	M=-1
	@END.BOOL.7
	D;JLT
	@SP
	A=M-1
	M=0
(END.BOOL.7)
//push constant 32766
	@32766
	D=A
	@SP
	M=M+1
	A=M-1
	M=D
//push constant 32767
	@32767
	D=A
	@SP
	M=M+1
	A=M-1
	M=D
//gt
	@SP
	A=M-1
	D=M
	@POSITIVE.Y.8
	D;JGE
	@SP
	A=M-1
	A=A-1
	D=M
	@REG.COMP.8
	D;JLT
	@SP
	AM=M-1
	A=A-1
	M=-1
	@END.BOOL.8
	0;JMP
	@END.BOOL.8
	0;JMP
(POSITIVE.Y.8)
	@SP
	A=M-1
	A=A-1
	D=M
	@REG.COMP.8
	D;JGE
	@SP
	AM=M-1
	A=A-1
	M=0
	@END.BOOL.8
	0;JMP
(REG.COMP.8)
	@SP
	AM=M-1
	D=M
	A=A-1
	D=D-M
	@SP
	A=M-1
	M=-1
	@END.BOOL.8
	D;JLT
	@SP
	A=M-1
	M=0
(END.BOOL.8)
//push constant 32766
	@32766
	D=A
	@SP
	M=M+1
	A=M-1
	M=D
//push constant 32766
	@32766
	D=A
	@SP
	M=M+1
	A=M-1
	M=D
//gt
	@SP
	A=M-1
	D=M
	@POSITIVE.Y.9
	D;JGE
	@SP
	A=M-1
	A=A-1
	D=M
	@REG.COMP.9
	D;JLT
	@SP
	AM=M-1
	A=A-1
	M=-1
	@END.BOOL.9
	0;JMP
	@END.BOOL.9
	0;JMP
(POSITIVE.Y.9)
	@SP
	A=M-1
	A=A-1
	D=M
	@REG.COMP.9
	D;JGE
	@SP
	AM=M-1
	A=A-1
	M=0
	@END.BOOL.9
	0;JMP
(REG.COMP.9)
	@SP
	AM=M-1
	D=M
	A=A-1
	D=D-M
	@SP
	A=M-1
	M=-1
	@END.BOOL.9
	D;JLT
	@SP
	A=M-1
	M=0
(END.BOOL.9)
//push constant 57
	@57
	D=A
	@SP
	M=M+1
	A=M-1
	M=D
//push constant 31
	@31
	D=A
	@SP
	M=M+1
	A=M-1
	M=D
//push constant 53
	@53
	D=A
	@SP
	M=M+1
	A=M-1
	M=D
//add
	@SP
	AM=M-1
	D=M
	A=A-1
	M=M+D
//push constant 112
	@112
	D=A
	@SP
	M=M+1
	A=M-1
	M=D
//sub
	@SP
	AM=M-1
	D=M
	A=A-1
	M=M-D
//neg
	@SP
	A=M-1
	M=-M
//and
	@SP
	AM=M-1
	D=M
	A=A-1
	M=M&D
//push constant 82
	@82
	D=A
	@SP
	M=M+1
	A=M-1
	M=D
//or
	@SP
	AM=M-1
	D=M
	A=A-1
	M=M|D
//not
	@SP
	A=M-1
	M=!M
