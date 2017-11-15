#!/bin/bash
echo "*** Template Shell Script ***"
echo Desc : ........
echo Author : gengkun123@gmail.com
echo "*** Run time: $(date) @ $(hostname)"
echo

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" 

for file in $DIR/*.*
do
	echo $file
done

echo "========="

function read_dir(){
    for file in `ls $1`
    do
        if [ -d "$1/$file" ]
        then
            read_dir $1"/"$file
        else
            echo $1"/"$file
        fi
    done
}
#测试目录 test
read_dir $DIR

