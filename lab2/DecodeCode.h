#ifndef DECODE_CODE_H
#define DECODE_CODE_H

typedef struct _mipsinstruction{
	int opcode; 	// unsigned opcode
	int func;  	// unsigned function code
	int rs;		// unsigned rs field
	int rd;		// unsigned rd field
	int rt;		// unsigned rt field
	int imm;	// signed immediate field
} mipsinstruction;

mipsinstruction decode(int);

#endif
