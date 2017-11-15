#!/bin/bash
echo "*** Template Shell Script ***"
echo Desc : ........
echo Author : gengkun123@gmail.com
echo "*** Run time: $(date) @ $(hostname)"
echo

allFiles() {
	for file in $1/*
	do
	if [ -d $file ]; then
		allFiles $file
	else
		echo $file
	fi
	done
}

testdir=~/work/shell
allFiles $testdir

echo "========================================="
for i in *.sh; do
	echo "name:$i"
done
