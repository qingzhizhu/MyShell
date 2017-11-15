#!/bin/bash
echo "*** Template Shell Script ***"
echo Desc : ........
echo Author : gengkun123@gmail.com
echo "*** Run time: $(date) @ $(hostname)"
echo
read -p "Enter any file name : " filename

#if file exists copy it
if [ -f "${filename}" ]
then
	cp -v "$filename" /tmp
else
	echo "$0: $filename not found."
fi

