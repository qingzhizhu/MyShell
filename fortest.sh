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

#测试
testStr=""

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



USER_MASTER_NUM=-1
echo "$USER_MASTER_NUM"
let USER_MASTER_NUM=$USER_MASTER_NUM+1
echo "$USER_MASTER_NUM"
let USER_MASTER_NUM=$USER_MASTER_NUM+1
echo "$USER_MASTER_NUM"


echo "------------"



echo "字典操作"
#master
USER_NUM=0
USER_ARR=("gengkun" "master" "耿坤" "AA")
USER_ARR_PATH=(".")
DIC_USER=([$USER_NUM]=${USER_ARR[*]})
DIC_PATH=([$USER_NUM]=${USER_ARR_PATH[*]})

echo ${!DIC_USER[*]}
echo ${DIC_USER[*]}
echo "------------"

#开发权限
let USER_NUM=$USER_NUM+1
USER_ARR=("dev" "dev1" "dev2" "dev3")
USER_ARR_PATH=("b" "dev" "art")
DIC_USER+=([$USER_NUM]=${USER_ARR[*]})
DIC_PATH+=([$USER_NUM]=${USER_ARR_PATH[*]})
echo ${!DIC_USER[*]}
echo ${DIC_USER[*]}
echo "------------"


#开发权限
let USER_NUM=$USER_NUM+1
USER_ARR=("art" "art1" "art2" "art3")
USER_ARR_PATH=("art", "ART2")
DIC_USER+=([$USER_NUM]=${USER_ARR[*]})
DIC_PATH+=([$USER_NUM]=${USER_ARR_PATH[*]})
echo ${!DIC_USER[*]}
echo ${DIC_USER[*]}
echo "------------"


echo "遍历字典"

for key in $(echo ${!DIC_USER[*]})
do
    echo $key":"${DIC_USER[key]}
done

echo "遍历字典PATH"
for key in $(echo ${!DIC_PATH[*]})
do
    echo $key":"${DIC_PATH[key]}
done



 

#用法：

s="{\"rv\":0,\"flag\":1,\"url\":\"http://www.jinhill.com\",\"msg\":\"test\"}"  
parse_json(){  
	#echo "$1" | sed "s/\(.*\)$2\":[^,}]*\(.*\)/\1/"
	#echo "${1//\"/}" | sed "s/\(.*\)$2:\[^,}]*\(.*\)/\1/"
	echo "${1//\"/}" | sed "s/\(.*\)$2:[^,}]\(.*\)/\d/" 
	#echo  $1 		 | sed 's/.*"url" :\([^,}]*\).*/\1/'
}  
echo $s 
echo "----" 
value=$(parse_json $s "url")  
echo $value  





function get_json_value()
{
  local json=$1
  local key=$2
  #echo "json=$json"
  if [[ -z "$3" ]]; then
    local num=1
  else
    local num=$3
  fi
  local value=$(echo "${json}" | awk -F"[,:}]" '{for(i=1;i<=NF;i++){if($i~/'${key}'\042/){print $(i+1)}}}' | tr -d '"' | sed -n ${num}p)
  echo ${value}
}

#get_json_value $(curl -s http://ip.taobao.com/service/getIpInfo.php?ip=myip) ip

author="gengkun1"
author_id=`get_json_value $(curl -s http://10.1.3.38/api/v4/users?username=${author}) id`
if [[ $author_id == "" ]]; then
	echo "非法用户"
fi
echo "author_id=$author_id"


str='[{"key":"path","value":"\"dir_1\" \"dir_2 a/art\" \"a/art/newdir\"","protected":false}]'

str='[{"key":"path","value":"aa","protected":false}]'
#'[{"key":"path","vaaalue":"a;art;BattleServer;  Gds;  Hypersync;Proto;Tools;Client/Unity/Assets/CustomAssets;","protected":false}]'
echo "str=$str"
echo "-====="
str=`echo $str | sed s/[[:space:]]//g`
echo "先去调空格str=$str"
value=`get_json_value $str value`
echo "value=$value"

OLDIFS=$IFS
echo "IFS=$IFS@@@"
IFS=";"
for i in $value; do
	echo "i=$i"
done
IFS=$OLDIFS




testStr=".gitignore                                         |   7 ++++++-\n
aaa\n
parent:11\n
aa\n
a parent:22\n
"
echo $testStr |grep -a "parent"
echo "==="
COUNT=$(echo $testStr |grep -a "parent" |wc -l) 
echo "parent出现的次数$COUNT"

#grep -o 'select' $testStr |wc -l
#awk -v RS="@#$j" '{print gsub(/parent/,"&")}' < $testStr
COUNT=$testStr | grep "parent" -c
echo "字符串必须换行才能输出..次数:$COUNT"





change=`cat /Users/kevin/elex/cod/cod_project/log.txt | sed 's/ //g'`

for i in $change; do
        #判断是否有 /
        echo "普通提交,包含斜杠:$i"
      if [[ $i =~ "/" ]]; then
        #echo "普通提交,包含斜杠:$i"
        #changePath=("${changePath[@]}" "${i%/*}")
        tempPath="${i%/*} "
        if [[ $changePath =~ $tempPath ]]; then
          #echo "changePath包含tempPath;@$changePath;$tempPath@"
          continue
        fi
        changePath="$changePath$tempPath"
        #echo "@@$changePath"

      #是否是个根目录下的文件, TODO 看需求是否禁用不包含.的跟目录文件
      #else
      elif [[ $i =~ "." ]]; then

        echo "Error: $author_name没权限在!根!目录下提交文件权限"
        break
        #exit 1

      else
        echo "其他字符：$i"
        :
      fi
    done

echo "你可以提交了"

str=".gitignore"
if [[ $str =~ ".gitignore" ]]; then
  echo "包含啊"
fi


str="Client/Unity/Assets/CustomAssets/Resources/LocalFilePath.txt
Client/Unity/Assets/CustomAssets/Resources/LocalFilePath.txt.meta
Client/Unity/Assets/CustomAssets/Resources/Prefabs/UI/Features/PveHomeNewView/PveHomeNewView.prefab
Client/Unity/Assets/CustomAssets/Scripts/Model/ClientSync/Protocols/Commands.cs
Client/Unity/Assets/CustomAssets/Scripts/Model/ClientSync/Protocols/Models.cs
Client/Unity/Assets/CustomAssets/Scripts/View/Ui/PveHomeNewView/PveHomeNewView.cs"

if [[ $str =~ ".cs" ]]; then
  echo "包含.cs 文件啊！"
fi

