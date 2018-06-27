#!/bin/bash
echo "*** gitlab 批量添加用户 ***"
echo Desc : ........
echo Author : gengkun123@gmail.com
echo "*** Run time: $(date) @ $(hostname)"
echo

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "DIR=$DIR"

GL_HOST="http://10.1.17.99"


function get_json_value()
{
  local json=$1
  local key=$2
  if [[ -z "$3" ]]; then
    local num=1
  else
    local num=$3
  fi
  local value=$(echo "$json" | awk -F"[,:}]" '{for(i=1;i<=NF;i++){if($i~/'$key'\042/){print $(i+1)}}}' | tr -d '"' | sed -n ${num}p)
  echo $value
}


#二维数组, 英文名，中文名，密码，邮件
#添加到组,Future4；管理员10； 前端11；后端12；策划14；art15;
a=(
	# 'lisiliang 李思亮 10'
	# 'gengkun 耿坤 10'
	# 'chenzixiang 陈子祥 10'
	# 'mali 马里 12'
	# 'huangyuanqiang 黄远强 12'
	# 'zhaozhenguo 赵振国 11'
	# 'zhangyicheng 张译成 11'
	# 'wangmengnan 王梦楠 14'
	# 'wujuan 吴娟 15'
	# 'wangwenchao 王文超 15'
	# 'menjiacheng 门家成 15'
	# 'yuanzaibao 原再葆 15'
	# 'test1 需要确认吗 11'
	# 'jinlei 靳雷 15'
	# 'zhouming 周明 15'
	# 'liumeng 刘萌 15'
	# 'zhangtao 张涛 15'
	# 'suchang 苏畅 14'
	'zhanglong 张龙 12'


  	)

user_id=0
name_e="test"
name_z="测试"
password="11111111"
email="${name_e}@elex-tech.com"
subgroup=0

for i in "${a[@]}" ; do
	b=($i) #此时b就相当于二维数组里面的一维数组了，然后可以再次遍历
	#echo "b=$i"
	name_e="${b[0]}"
	name_z="${b[1]}"
	email="${name_e}@elex-tech.com"
	subgroup="${b[2]}"

	#echo "name_e=$name_e;name_z=$name_z;pwd=$password;email=$email"

	ret=$(curl "$GL_HOST/api/v3/users?search=$name_e&private_token=CWddeK1ARRdka6h--jVQ")

	user_id=0

	if [[ $ret =~ "id" ]]; then
		# echo "包含此用户"
		user_id=`get_json_value $ret id`
	else	
		ret=$(curl -d "skip_confirmation=false&password=$password&email=$email&username=$name_e&name=$name_z&private_token=CWddeK1ARRdka6h--jVQ" "$GL_HOST/api/v4/users")
	# echo $ret
		user_id=`get_json_value $ret id`

	fi
	echo "用户id：$user_id"

	curl --request POST --header "PRIVATE-TOKEN: CWddeK1ARRdka6h--jVQ" --data "user_id=$user_id&access_level=30" $GL_HOST/api/v4/groups/4/members
	curl --request POST --header "PRIVATE-TOKEN: CWddeK1ARRdka6h--jVQ" --data "user_id=$user_id&access_level=30" $GL_HOST/api/v4/groups/$subgroup/members

done

echo "done!"

















#添加用户










