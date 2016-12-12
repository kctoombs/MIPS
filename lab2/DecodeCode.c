#include "DecodeCode.h"


mipsinstruction decode(int value)
{
  mipsinstruction instr;
  int funcMask = 0X0000003f;
  int rdMask = 0X0000001f;
  int rtMask = 0X0000001f;
  int rsMask = 0X0000001f;
  int opcodeMask = 0X0000003f;
  int immMask = 0X0000ffff;
  int immMask2 = 0X00008000;
  int immMask3 = 0Xffff0000;
    
  instr.opcode = (opcodeMask & (value >> 26));
  instr.func = (funcMask & value);
  if((immMask2 & value == 0))
    instr.imm = (immMask & value);
  else
    instr.imm = (immMask3 | value);
  instr.rs = (rsMask & (value >> 21));
  instr.rt = (rtMask & (value >> 16));
  instr.rd = (rdMask & (value >> 11));

  return instr;
}


