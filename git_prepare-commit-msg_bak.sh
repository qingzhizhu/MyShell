#!/bin/bash
echo "*** Template Shell Script ***"
echo "Desc : git hook 客户端提交检查"
echo "Author : gengkun123@gmail.com"
echo "*** Run time: $(date) @ $(hostname)"
echo

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "DIR=$DIR"

#git 内部参数
#arr_git=("GIT_DIR", "GIT_CEILING_DIRECTORIES", "GIT_WORK_TREE", "GIT_INDEX_FILE", 
	#"GIT_OBJECT_DIRECTORY", "GIT_ALTERNATE_OBJECT_DIRECTORIES", "GIT_GLOB_PATHSPECS", "GIT_NOGLOB_PATHSPECS",
	# "GIT_LITERAL_PATHSPECS", "GIT_ICASE_PATHSPECS", "GIT_ICASE_PATHSPECS")
#echo "GIT_DIR=$GIT_DIR"
#for i in ${arr_git[@]}; do
	#echo `$i`
#done

echo "--------------"

echo "$GIT_CEILING_DIRECTORIES"
echo "$GIT_WORK_TREE"
echo "$GIT_INDEX_FILE"
echo "$GIT_OBJECT_DIRECTORY"
echo "$GIT_ALTERNATE_OBJECT_DIRECTORIES"
echo "$GIT_GLOB_PATHSPECS"
echo "$GIT_NOGLOB_PATHSPECS"
echo "$GIT_LITERAL_PATHSPECS"
echo "$GIT_ICASE_PATHSPECS"
echo "$GIT_ICASE_PATHSPECS"
echo "GIT_EXEC_PATH=$GIT_EXEC_PATH"
echo "PREFIX=$PREFIX"
echo "GIT_PAGER=$GIT_PAGER"
echo "GIT_EDITOR=$GIT_EDITOR"
echo "GIT_DIFF_OPTS=$GIT_DIFF_OPTS"
echo "GIT_EXTERNAL_DIFF=$GIT_EXTERNAL_DIFF"
echo "GIT_DIFF_PATH_COUNTER=$GIT_DIFF_PATH_COUNTER"
echo "GIT_DIFF_PATH_TOTAL=$GIT_DIFF_PATH_TOTAL"
echo "GIT_MERGE_VERBOSITY=$GIT_MERGE_VERBOSITY"

echo "--------------"
for i in $*; do
	echo $i
done

echo "--------------"



git status -s
echo "--------------"
change=`git status -s`
#echo "change=$change"


oldIFS=$IFS
#IFS="\n"
num=1
for i in $change; do
	if [[ $i == "M" || $i == "MM" || $i == "A" || $i == "AM" ]]; then
		echo "$i==MMMMM"
		#check
	fi
	echo "$i"
	echo "--------"
done
IFS=$oldIFS

echo "--------------"

echo "当前提交用户:$GIT_AUTHOR_NAME"



#master
USER_MASTER_NUM=0
USER_MASTER=("耿坤" "AA")
USER_MASTER_PATH=(".")

#开发权限
USER_DEV_NUM=1
USER_DEV=("dev1" "dev2" "dev3")
USER_DEV_PATH=("art" "dev")

#美术权限
USER_ART_NUM=2
USER_ART=("art1" "art2")
USER_ART_PATH=("art")


#echo ${USER_DEV[*]}

#declare -A DIC_USER
DIC_USER=([$USER_MASTER_NUM]=${USER_MASTER[*]}, [$USER_DEV_NUM]=${USER_DEV[*]}, [$USER_ART_NUM]=${USER_ART[*]})
DIC_PATH=([$USER_MASTER_NUM]=${USER_MASTER_PATH[*]}, [$USER_DEV_NUM]=${USER_DEV_PATH[*]}, [$USER_ART_NUM]=${USER_ART_PATH[*]})

#遍历key值
#$GIT_AUTHOR_NAME
TMP_GIT_AUTHOR="dev3"
for key in $(echo ${!DIC_USER[*]})
do
        echo "$key : ${DIC_USER[$key]}"
        arr=${DIC_USER[$key]}
		if echo "${arr[@]}" | grep -w "$TMP_GIT_AUTHOR" &>/dev/null; then
			echo "Found_user:$TMP_GIT_AUTHOR"
			echo "path:${DIC_PATH[$key]}"
			for i in ${DIC_PATH[$key]}; do
	        	echo "path=@@$i@@"
	        done
		fi
        echo "======"
done




if [[ $GIT_AUTHOR_NAME == "耿坤" ]]; then
	echo "这个用户有权限"
	
fi


echo "don't commit!"


exit 1



#test 
#cp /Users/kevin/elex/shell/git_prepare-commit-msg.sh .git/hooks/prepare-commit-msg