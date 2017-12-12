#!/bin/bash
#echo "*** Template Shell Script ***"
#echo "Desc : git 下载所有分支"
#echo "Author : gengkun123@gmail.com"
#echo "*** Run time: $(date) @ $(hostname)"

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "DIR=$DIR"

git fetch -all
git pull -all

#所有分支， 也可以用 for remote in `git branch -r | grep -v '\->'`; do git branch --track $remote; done
testStr="
  origin/develop
  
"


echo "----stat----"
for i in ${testStr[@]}; do
	echo "branch---$i"
	#echo "@@${i#*/}"
	git branch ${i#*/} $i
done

echo "----Done!!!----"





