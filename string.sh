#!/bin/bash

echo "*** 字符串 Shell Script ***"
echo Desc : ........
echo Author : gengkun123@gmail.com
echo "*** Run time: $(date) @ $(hostname)"
echo

uuid=""
ip="a"



if [ -z $uuid ]; then
	echo "uuid is empty"
fi

if [ -n "$uuid" ] ||  [ -n "$ip" ]
then
	echo "有一个不为空"
else
	echo "都为空"
fi

str='abcdef'
echo ${str:2}           "从第二个位置开始提取字符串， bcdef"
echo ${str:2:3}         "从第二个位置开始提取3个字符, bcd"
echo ${str:(-2)}        "从倒数第二个位置向右提取字符串, ef"
echo ${str:(-2):3}      "从倒数第二个位置向右提取3个字符, ef"

str="abbc,def,ghi,abcjkl"
echo "${str#a*c}"."一个井号(#) 表示从左边截取掉最短的匹配 (这里把abbc字串去掉）"
echo "${str##a*c}"."两个井号(##) 表示从左边截取掉最长的匹配 (这里把abbc,def,ghi,abc字串去掉)"
echo ${str#"a*c"} "空,因为str中没有子串\"a*c\""
echo ${str%a*l} "一个百分号(%)表示从右边截取最短的匹配, abbc,def,ghi"
echo ${str%%b*l} "两个百分号表示(%%)表示从右边截取最长的匹配 a"



echo "--------------"

#http://blog.wtlucky.com/blog/2013/05/02/start-write-shell/
exit 0

for aFile in *; do
    #对变量加上双引号会避免文件名中有空格的问题
    tmpFile=`basename "$aFile"`
    #截取文件名字符串中的前一部分
    newName=${tmpFile#C*-}
    echo 原文件名：${tmpFile}
    echo 新文件名：${newName}
    #对文件进行重命名
    mv "$tmpFile" "$newName"
done




