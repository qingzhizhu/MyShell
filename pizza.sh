#!/bin/bash
echo "*** Template Shell Script ***"
echo Desc : \$@ 和 \$* 不同
echo Author : gengkun123@gmail.com
echo "*** Run time: $(date) @ $(hostname)"
echo
IFS=", "
echo "* Displaying all pizza names using \$@"
echo "$@"
echo 
 
echo "* Displaying all pizza names using \$*"
echo "$*"
