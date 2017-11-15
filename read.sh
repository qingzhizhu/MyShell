#!/bin/bash
echo "*** Template Shell Script ***"
echo Desc : 读取参数测试.
echo Author : gengkun123@gmail.com
echo "*** Run time: $(date) @ $(hostname)"
echo

read -r login password uid gid info home shell <<< "$pwd"
printf "Your login name is %s, uid %d, gid %d, home dir set to %s with %s as login shell\n" $login $uid $gid $home $shell

nameservers="ns1.nixcraft.net ns2.nixcraft.net ns3.nixcraft.net"
echo "$nameservers"
read -r ns1 ns2 ns3 <<< "$nameservers"
printf "read -r cmd : DNS Server #1 %s\n #2 %s\n #3 %s\n" $ns1 $ns2 $ns3

read -p "Enter your name : " name
echo "Hi, $name. Let us be Friends!"

read -s -p "Enter password : " pwd
echo "pwd:$pwd"

read -t 3 -p "3秒过期" test
echo "input:$test"

