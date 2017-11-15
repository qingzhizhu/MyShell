#!/bin/bash
#echo "*** Template Shell Script ***"
#echo "Desc : git hook 客户端提交检查"
#echo "Author : gengkun123@gmail.com"
#echo "*** Run time: $(date) @ $(hostname)"

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "DIR=$DIR"

testStr=".gitignore                                         |   7 ++++++-
Client/Unity/Library/BuildSettings.asset           | Bin 0 -> 4152 bytes
Client/Unity/Library/EditorUserBuildSettings.asset | Bin 0 -> 4672 bytes
Client/Unity/Assets/{ => CustomAssets}/artFont.meta                             |   0
.../Scripts/Model/ClientSync/City/CityMap.cs       | 33 ++++++++----------
a/a.txt     | 1 +
art/art.txt | 1 +
"

 echo  "testStr=$testStr"

 # stat=( `cat /proc/$$/testStr` )
 # echo "stat=$stat"


changePath=""
testStr=`echo $testStr | sed 's/^\/ //' `
 echo  "testStr22=$testStr"

 for i in ${testStr[@]}; do
 	#判断是否有... 冲突
 	if [[ $i =~ "..." ]]; then
 		echo "冲突提交，包含...不用检查此提交记录:$i"
 	
 	#判断是否重命名操作{ }
 	elif [[ $i =~ "{" || $i =~ "}" ]]; then
 		echo "重命名提交，包含大括号，不用检查此提交记录:$i"
 	
 	
 	#判断是否有 / 
 	elif [[ $i =~ "/" ]]; then
 		echo "普通提交,包含斜杠:$i"
 		#changePath=("${changePath[@]}" "${i%/*}")
 		tempPath="${i%/*} "
 		if [[ $changePath =~ $tempPath ]]; then
 			echo "changePath包含tempPath;@$changePath;$tempPath@"
 			continue
 		fi
 		changePath="${changePath}$tempPath"
 		#echo "@@$changePath"
 	#是否是个根目录下的文件

 	else
 		echo "其他字符：$i"
 	fi
 	
 done

#changePath=$changePath | sed '$!N; /^\(.*\)\n\1$/!P; D'
#changePath=($(awk -vRS=' ' '!a[$1]++' <<< ${changePath[@]}))
echo "changePath=$changePath"
for i in $changePath; do
	echo "change.i=$i"
done

#message="Merge remote-tracking branch 'origin/develop' into develop"
message="Conflicts Meragea into develop"

if [[ $message =~ "Merge" ]]; then
	echo "这是一个merge提交，不检查，下一条"
elif [[ $message =~ "Conflicts" ]]; then
	echo "这是一个冲突提交，不检查，下一条"
fi

