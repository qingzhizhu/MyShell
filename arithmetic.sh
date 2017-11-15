#!/bin/bash
echo "*** Template Shell Script ***"
echo Desc : 算术表达式 
echo Author : gengkun123@gmail.com
echo "*** Run time: $(date) @ $(hostname)"
echo

<<COMMENT
       d++ id--
              variable post-increment and post-decrement
       ++id --id
              variable pre-increment and pre-decrement
       - +    unary minus and plus
       ! ~    logical and bitwise negation 逻辑非和按位取反
       **     exponentiation 求幂
       * / %  multiplication, division, remainder
       + -    addition, subtraction
       << >>  left and right bitwise shifts
       <= >= < >
              comparison
       == !=  equality and inequality
       &      bitwise AND
       ^      bitwise exclusive OR 按位异或
       |      bitwise OR
       &&     logical AND
       ||     logical OR
       expr?expr:expr 三目表达式
              conditional operator
       = *= /= %= += -= <<= >>= &= ^= |=
              assignment
       expr1 , expr2  逗号表达式
              comma

COMMENT
