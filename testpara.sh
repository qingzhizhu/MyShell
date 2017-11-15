#!/bin/bash
echo "*** Template Shell Script ***"
echo Desc : 读取命令后面的参数 e.g. sh testpara.sh one two "three four" 
echo Author : gengkun123@gmail.com
echo "*** Run time: $(date) @ $(hostname)"
echo
echo "*** Processing \$@ without double quote:"
for f in $@
do
	echo "\$f = $f"
done
 
echo "*** Processing \$@ with double quote:"
for f in "$@"
do
	echo "\$f = $f"
done
