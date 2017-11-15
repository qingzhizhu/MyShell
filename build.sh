#/bin/bash
echo "*** Lua Packing & Encryption ***"
#echo Desc : ........
# Author : gengkun123@gmail.com
# "*** Run time: $(date) @ $(hostname)"

VER=$1
if [ "$VER" = "" ]; then
clear
echo "Error Arguments. Usage: sh build.sh version"
exit 0
fi

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" 
DIR_CONFIG="config"
DIR_LUA="mylua"
DIR_IMG="image_$VER"
PKG_AND="package_a_$VER" 
PKG_AND_IMG="${PKG_AND}/images"
PKG_IOS="package_i_$VER"
PKG_IOS_IMG="${PKG_IOS}/images"
#lua use
DIR_LUA_OUT="${DIR_LUA}_out"
COMPILER=$COCOS2DX_ROOT/scripting/lua/luajit/LuaJIT-2.0.1/src/luajit
#LOCAL=1

echo
echo "---------DEBUG INFO BEGIN-----------------"
echo "DIR:		${DIR}"
echo "DIR_CONFIG:	${DIR_CONFIG}"
echo "DIR_LUA:	${DIR_LUA}"
echo "DIR_IMG:	${DIR_IMG}"
echo "PKG_AND:	${PKG_AND}"
echo "PKG_IOS:	${PKG_IOS}"
echo "PKG_IOS_IMG:	${PKG_IOS_IMG}"
echo "---------DEBUG INFO END-------------------"


echo $VER > version
#cat version

test -d "${PKG_AND}" && rm -r ${PKG_AND}
mkdir -v "${PKG_AND}"

test -d "${PKG_IOS}" && rm -r ${PKG_IOS}
mkdir -v "${PKG_IOS}"

cp -r ${DIR_CONFIG} ${PKG_AND}
cp -r ${DIR_CONFIG} ${PKG_IOS}

test -d "${DIR_LUA_OUT}" && rm -r ${DIR_LUA_OUT}
cp -r ${DIR_LUA} ${DIR_LUA_OUT}

for file in ${DIR_LUA_OUT}/*.lua; do
	echo "Encryption file:$file"
	$COMPILER -b $file $file
done
cp -r ${DIR_LUA_OUT} ${PKG_AND}/${DIR_LUA}
cp -r ${DIR_LUA_OUT} ${PKG_IOS}/${DIR_LUA}

mkdir -v "${PKG_AND_IMG}"
mkdir -v "${PKG_IOS_IMG}"

cp  ${DIR_IMG}/*.plist ${PKG_AND_IMG}
cp  ${DIR_IMG}/*.plist ${PKG_IOS_IMG}
cp  ${DIR_IMG}/*.pkm ${PKG_AND_IMG}
cp  ${DIR_IMG}/*.pvr.ccz ${PKG_IOS_IMG}
 
cd ${PKG_AND}
zip -r ${PKG_AND}.zip *
mv ${PKG_AND}.zip ../
cd ../${PKG_IOS}
zip -r ${PKG_IOS}.zip *
mv ${PKG_IOS}.zip ../
cd ../


rm -r ${DIR_LUA_OUT} ${PKG_AND} ${PKG_IOS}

if [ $LOCAL = 1 ]; then
	DIR_SITE=~/Sites/ra
	cp ${PKG_AND}.zip ${DIR_SITE}
	cp ${PKG_IOS}.zip ${DIR_SITE}
	cp version ${DIR_SITE}
	echo "upload to local server!"
	exit 0
fi


HOST=s1.eleximg.com
USER=ram-download
PASS=wQK1BcfyGm96Rc2

ftp -inv $HOST <<EOF 
user $USER $PASS
put version
put ${PKG_AND}.zip
put ${PKG_IOS}.zip
ls
bye
EOF


STATUS=$?
if [ $STATUS = 0 ]; then
	echo "Successful!!"
else
	echo "Error!!"
fi



