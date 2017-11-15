#!/bin/bash
#echo "*** Template Shell Script ***"
#echo "Desc : git hook 客户端提交检查"
#echo "Author : gengkun123@gmail.com"
#echo "*** Run time: $(date) @ $(hostname)"

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "DIR=$DIR"
echo "当前提交用户:$GIT_AUTHOR_NAME"





change=`git status -s`
echo "change=$change" #todo优化路径


#master
USER_MASTER_NUM=0
USER_MASTER=("gengkun" "master" "耿坤" "AA")
USER_MASTER_PATH=(".")

#开发权限
USER_DEV_NUM=1
USER_DEV=("dev" "dev1" "dev2" "dev3")
USER_DEV_PATH=("b" "dev" "art")

#美术权限
USER_ART_NUM=2
USER_ART=("art" "art1" "art2")
USER_ART_PATH=("a" "art")


#echo ${USER_DEV[*]}

#declare -A DIC_USER
DIC_USER=([$USER_MASTER_NUM]=${USER_MASTER[*]}, [$USER_DEV_NUM]=${USER_DEV[*]}, [$USER_ART_NUM]=${USER_ART[*]})
DIC_PATH=([$USER_MASTER_NUM]=${USER_MASTER_PATH[*]}, [$USER_DEV_NUM]=${USER_DEV_PATH[*]}, [$USER_ART_NUM]=${USER_ART_PATH[*]})

#遍历key值
#$GIT_AUTHOR_NAME
#后缀_art表示都是美术， _dev 都是程序
TMP_GIT_AUTHOR=$GIT_AUTHOR_NAME
tmpAuthor=${TMP_GIT_AUTHOR#*_}
#echo "tmpAuthor=$tmpAuthor"
if [[  $tmpAuthor == "art" ]]; then
	#echo "美术开发组"
	TMP_GIT_AUTHOR="art"
elif [[ $tmpAuthor == "dev" ]]; then
	#echo "程序开发组"
	TMP_GIT_AUTHOR="dev"
fi

needCheck=0
isGuest=1
for key in $(echo ${!DIC_USER[*]})
do
        #echo "$key : ${DIC_USER[$key]}"
        arr=${DIC_USER[$key]}
		if echo "${arr[@]}" | grep -w "$TMP_GIT_AUTHOR" &>/dev/null; then
			isGuest=0
			#echo "path:${DIC_PATH[$key]}"
			#for i in ${DIC_PATH[$key]}; do
	        #	echo "path=@@$i@@"
	        #done
	        userPath=${DIC_PATH[$key]}
	        #echo "userPath=${userPath}"
	        if [[ "${userPath}" == "." || "${userPath}" == ".,"  || "$userPath[0]" == "." ]]; then
	        	#echo "you are master"
				exit 0
			fi
			

			#文件检测是否在允许的路径中
			needCheck=0
			for i in $change; do
				file=$i
				#echo $file
				if [[ $needCheck == 1 ]]; then
					#echo "@@=${userPath[@]}, $file"
					filepath=${file%/*}
					#echo "$file -> $filepath"
					isEnable=1
					msg=""
					for path in $userPath; do
						#只要在其中一个就行
						if [[ $filepath =~ $path  ]]; then
							isEnable=1
							msg=""
							break
						else
							msg="$msg\r\n$file not in $path"
							isEnable=0
						fi
					done

					if [[ $isEnable == 0 ]]; then
						echo -e "Error!!! don't commit!!! \nYou can Access dir are : ${userPath} $msg"
						exit 1
					fi
					
					needCheck=0
				fi
				if [[ $file == "M" || $file == "MM" || $file == "A" || $file == "AM" ]]; then
					needCheck=1
				fi


			done

			
			break;
		else
			:


		fi
        
done


if [[ $isGuest == 1 ]]; then
	echo "当前提交用户:$GIT_AUTHOR_NAME"
	echo "Error: you don't have any Access！"
	exit 1
fi


#echo "you can commit!"


exit 0



#test 
#cp /Users/kevin/elex/shell/git_prepare-commit-msg.sh .git/hooks/prepare-commit-msg