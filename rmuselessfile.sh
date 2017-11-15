#!/bin/bash
echo "*** Template Shell Script ***"
echo Desc : 删除没用的文件
echo Author : gengkun123@gmail.com
echo "*** Run time: $(date) @ $(hostname)"
echo

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" 

DIR_PRO="/Users/Kevin/work3/gow_frontend"

DIR_PRO_CPP="$DIR_PRO/IF/Classes"
DIR_PRO_LUA="$DIR_PRO/proj.lua/ba_lua/src"
DIR_CCB="$DIR_PRO/CCB/IF/Resources"
DIR_PNG="$DIR_PRO/CCB/IF"

DIR_PRO_RES="$DIR_PRO/IF/Resources"
#res ccbi
DIR_PRO_RES_CCBI="$DIR_PRO_RES/ccbi"

RMTXT="rm.txt"

echo "$(date)=========" > $RMTXT

TYPE=0
echo "TYPE=1 check CCB files"
echo "TYPE=2 check png files"


#遍历资源
function read_dir(){
    for file in `ls $1`
    do
        if [ -d "$1/$file" ]; then
        	if [ $TYPE == 2 ]; then            	
            	if [[ "$1/$file" == $DIR_CCB 
            		|| "$1/$file" == "$DIR_PNG/Battle" 
            		|| "$1/$file" == "$DIR_PNG/Titans" 
            		|| "$1/$file" == "$DIR_PNG/World" 
            		|| "$1/$file" == "$DIR_PNG/Common/Common_701" 
            		|| "$1/$file" == "$DIR_PNG/Particle" 
            		]]; then
            		echo "PNG 过滤 DIR=$1/$file"
            		continue
            	fi
            fi
            read_dir "$1/$file"
        else
        	if [ $TYPE == 1 ]; then
            	findCCB "$1/$file"
            elif [ $TYPE == 2 ]; then
            	findPNG "$1/$file"            	
            else
            	echo "TYPE=$TYPE error!"
            fi
        fi
    done
}

#查找是否存在
#@param1 名字
#@param2 路径
function findInDir(){
	#echo "@$1@$2"
	grep --color -r -n $1 $2
	#if [ $? -eq 1 ]; then
		#echo "ccb $1 没有在用？！" >> $RMTXT
	#fi
	return $?
}

function findCCB(){
	#echo "type=1 CCB@@@$1"
	
	file=${1#$DIR_CCB*/}
	#
	if [[ $file == "ImperialCities_2_setting.ccb" || $file == "ImperialCities_2.ccb" ]]; then
		echo "忽略  $file"
		return
	fi
	#echo $1
	#return

	name="${file%.*}"
	echo "name1=$name"
	name_cpp="\"$name\""
	echo "name2=$name_cpp"	

	#echo "(\"${file}i\""

	#cpp文件不存在
	grep --color -r -n $name_cpp $DIR_PRO_CPP/*
	if [ $? -eq 1 ]; then
		#echo "ccb $1 没有在用？！" >> $RMTXT
		#带.ccbi存在吗
		name_cpp="\"${file}i\""
		grep --color -r -n $name_cpp $DIR_PRO_CPP/*		
		if [ $? -eq 1 ]; then
			#lua中存在吗
			name_lua="['\"]$name['\"]"
			echo $name_lua
			grep --color -r -n $name_lua $DIR_PRO_LUA/*
			if [ $? -eq 1 ]; then
				echo "$file" >> $RMTXT
			fi
		fi		
	fi
}

function findPNG(){
	#echo "type=2 PNG@@@$1"
	file=${1#$DIR_PNG*/}
	
	if [[ ${file#*.} != "png" ]]; then
		return
	fi

	#echo "22@=$file"
	#return

	name="${file##*/}"
	echo $name

	#ccb 中是否使用
	#lua 中是否使用
	#RES 中是否使用
	#c++ 中是否使用
	
	#ccb 中是否使用
	grep --color -r -n $name $DIR_CCB/*
	if [ $? -eq 1 ]; then
		#lua中存在吗
		name_lua="['\"]$name['\"]"
		echo $name_lua
		grep --color -r -n $name_lua $DIR_PRO_LUA/*
		if [ $? -eq 1 ]; then
			#res中存在吗
			name_res="\"${name%.*}\""
			grep --color -r -n $name_res $DIR_PRO_RES/*
			if [ $? -eq 1 ]; then
				#cpp文件不存在
				grep --color -r -n $name $DIR_PRO_CPP/*
				if [ $? -eq 1 ]; then


				echo "$file" >> $RMTXT
				echo "不存在$file"
				#exit
				fi
			fi
		fi
	fi

}


#测试目录 test
echo "检测ccb是否使用 在c++,lua中都没有使用？！ 前面带#代表暂时留着" >> $RMTXT
date_start="$(date +%s)"
TYPE=1
#read_dir $DIR_CCB
date_end="$(date +%s)"
diff=$[date_end - date_start]
echo "检测ccb 用时 `echo $diff/60|bc` Mins, `echo $diff%60|bc` Secs." >> $RMTXT

echo "检测png是否使用 在c++,ccb,lua中都没有使用？！ 前面带#代表暂时留着" >> $RMTXT
date_start="$(date +%s)"
TYPE=2
read_dir $DIR_PNG
date_end="$(date +%s)"
diff=$[date_end - date_start]
echo "检测png 用时 `echo $diff/60|bc` Mins, `echo $diff%60|bc` Secs." >> $RMTXT

#test
#grep --color --color -r -n "['\"]ActivityListAdView['\"]" ~/work3/gow_frontend/proj.lua/ba_lua/src/*

#name_cpp="['\"]ActivityListAdView['\"]" #不要加空格，否则搜索不出来
#echo "grep --color -r -n $name_cpp ~/work3/gow_frontend/proj.lua/ba_lua/src/*"
#echo "====="
#grep --color -r -n $name_cpp ~/work3/gow_frontend/proj.lua/ba_lua/src/* 



#grep --color -r -n "account/account_related(/.ccbi)?" ~/work3/gow_frontend/IF/Classes/*
#name_cpp="account/account_related*" #不能加\" 否则搜索不出来
#echo "======aaa"
#echo "grep --color -r -n $name_cpp $DIR_PRO_CPP/*"
#grep --color -r -n $name_cpp $DIR_PRO_CPP/*



RMTXT_CCB="rmccb.txt"
#备份目录
DIR_CCB_DEL_BAK="$DIR_PRO/del_back/ccb"

num=0
function rmccb(){

	[ ! -d $DIR_CCB_DEL_BAK ] && mkdir -p $DIR_CCB_DEL_BAK

	echo "删除ccb============"

	text=`cat $RMTXT_CCB`
	#echo $text
	num=0
	for line in $text
	do
		if [ ${line:0:1} == "#" ]; then
			continue
		fi

		if [ ${line#*.} != "ccb" ];then
			#echo $line"@@@@"
			continue
			#exit 0
		fi

		let num+=1

		echo "$line"
		file_path=$DIR_CCB/$line
		if [ ! -f $file_path ]; then
			echo "$file_path not exits!"
			continue
		fi

		cp -rf $file_path $DIR_CCB_DEL_BAK
		rm -rf $file_path
		file_path_ccbi="$DIR_PRO_RES_CCBI/${line}i"
		echo "$file_path_ccbi"
		rm -rf $file_path_ccbi
		
		#exit
	done

	echo "删除多余CCB $num"
}

#rmccb

#png 删除

RMTXT_PNG="rmpng.txt"
#备份目录
DIR_PNG_DEL_BAK="$DIR_PRO/del_back/png"

num=0
function rmpng(){

	[ ! -d $DIR_PNG_DEL_BAK ] && mkdir -p $DIR_PNG_DEL_BAK

	echo "删除PNG============"

	text=`cat $RMTXT_PNG`
	#echo $text
	num=0
	for line in $text
	do
		if [ ${line:0:1} == "#" ]; then
			continue
		fi

		if [ ${line#*.} != "png" ];then
			#echo $line"@@@@"
			continue
			#exit 0
		fi

		let num+=1

		echo "$line"
		file_path=$DIR_PNG/$line
		if [ ! -f $file_path ]; then
			echo "$file_path not exits!"
			continue
		fi


		todir=$DIR_PNG_DEL_BAK/${line%/*}
		#echo "$todir"
		[ ! -d $todir ] && mkdir -p $todir

		cp -rf $file_path $todir
		rm -rf $file_path
		
		#exit
	done

	echo "删除多余PNG $num"
}

#rmpng


