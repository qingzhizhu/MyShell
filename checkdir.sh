#!/bin/bash
echo "*** Template Shell Script ***"
echo Desc : Make sure dir does not exist, else display an error message
echo Author : gengkun123@gmail.com
echo "*** Run time: $(date) @ $(hostname)"
echo
# Use variables 
BASE="/tmp"

read -p "Enter any directory name : " directory 
 
# create a path
mydir="${BASE}/${directory}"
 
# Make sure dir does not exits
if [ ! -d "${mydir}" ]
then
	mkdir -v "${mydir}" 
else
	echo "$0: ${mydir} already exists."
fi
