#include "stdio.h"
#include "stdlib.h"

int multiplyBy8(int v)
{
  // TODO: multiply the number by 8
  return v << 3;  //multiply by 8 by shifting bits to the left 3 times
}

int setBit6to1(int v)
{
  // TODO: set bit 6 to 1
  int  mask = 0X00000040;  // mask in binary: 0100 0000. Isolates bit 6.
  return (mask | v);
}

int setBit3to0(int v)
{
  // TODO: set bit 3 to 0
  int mask = 0Xfffffff7; // mask in binary: 1111 1111 1111 1111 1111 1111 1111 0111. Isolates bit 3.
  return (mask & v);
}
	
int flipBit5(int v)
{
  // TODO: flip bit 5 (if it is 0, make it 1.  If 0, make 1)
  int mask = 0X00000020; // mask in binary: 0010 0000. Isolates bit 5.
  return (v ^ mask);
}
	
int ifBit7is0(int v)
{
  // TODO: check to see if bit 7 is a 0 - return 1 if true, 0 if false
  int mask = 0X00000080; //mask in binary: 1000 0000. Isolates bit 7.
  if((v & mask) == 0)
    return 1;
  else
    return 0;
}

int ifBit3is1(int v)
{
  // check to see if bit 3 is a 1 - return 1 if true, 0 if false
  int mask = 0X00000008; //mask in binary: 1000. Isolates bit 3.
  if((mask & v) == 0)
    return 0;
  else
    return 1;
	
}

int unsignedBits0through5(int v)
{
  // return the unsigned value in bits 0 through 5
  int mask = 0X0000003f; // mask in binary: 0011 1111. Isolates bits 0-5.
  return (mask & v);
}

int unsignedBits6through9(int v)
{
  // return the unsigned value in bits 6 through 9
  int mask = 0X0000000f; 
  int shiftv = v  >> 6;
  return (mask & shiftv);
}

int signedBits0through5(int v)
{
  // return the signed value in bits 0 through 5
  int mask = 0Xffffffdf;            //1111 1111 1111 1111 1111 1111  1101 1111. Isolates bit 5.
  int mask2 = 0Xffffffc0;
  if((v & mask) == v)               //see if bit 5 is 0. If it's 0, then it's unsigned.   
    return unsignedBits0through5(v);
  else                              //else, bit 5 is 1, so return signed value.
    return(mask2 | v);
}

int signedBits6through9(int v)
{
  // return the signed value in bits 6 through 9
  int mask = 0Xfffffdff;           //1111 1111 1111 1111 1111 1101 1111 1111. Isolates bit 9.
  int mask2 =0Xfffffff0;
  if((v & mask) == v)              //see if bit 9 is 0. If it's 0, then it's unsigned.
    return unsignedBits6through9(v);
  else{                            //else, bit 9 is 1,  so return the signed value.
    int shiftv = v >> 6;
    return (mask2 | shiftv);
  }
}

int setBits4through9(int v, int setValue)
{
  // set bits 4 through 9 in v to become setValue
  int mask = 0X000003f0;                       //mask in binary: 0011 1111 0000. Isolates bits 4-9.
  int shiftSetValue = (setValue << 4);         //shift setValue 4 to the left so it is in the correct place.
  int set4through9 = (shiftSetValue & mask);   
  int newv = (v & 0Xfffffc0f);                 //make all bits of v 0.
  return(newv | set4through9);
}




