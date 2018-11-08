#!/bin/bash
set -euo pipefail
#set -x

echo "*** Template Shell Script ***"
echo Desc : md5 测试 
echo Author : gengkun123@gmail.com
echo "*** Run time: $(date) @ $(hostname)"
echo

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "DIR=$DIR"

dir_name="md5test"

[ ! -d $dir_name ] && mkdir $dir_name

 touch -m -a "Nov  8 17:18:51 2018" $dir_name
echo "dir md5="
tar c - "$dir_name" | md5sum
#===============================
 touch -m -a "Nov  8 17:18:51 2018" $dir_name
cp -P hello.sh $dir_name/1.txt
ls $dir_name
echo "dir md5 1="
tar c - "$dir_name" | md5sum
rm $dir_name/1.txt
echo "有操作就会改变文件夹的修改时间，导致md5不同"

#===============================
 touch -m -a "Nov  8 17:18:51 2018" $dir_name
echo "dir md5 2="
tar c - "$dir_name" | md5sum

echo "touch 设置成相同的时间md5不变"

echo "Done!"