#!/bin/bash
echo "*** Template Shell Script ***"
echo Desc : 变量检查，变量检查没定义则推出
echo Author : gengkun123@gmail.com
echo "*** Run time: $(date) @ $(hostname)"
echo
path=${1:?Error command line argument not passed}
echo "Backup path is $path"
echo "I'm done if \$path is set."
