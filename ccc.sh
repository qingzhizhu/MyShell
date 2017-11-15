#! /bin/bash
direc=$(pwd)"/Library/Developer/Xcode/DerivedData"
files=$(ls $direc)
for file in $files ; do
	cutname=$(echo $file | cut -b -11)
	if [ $cutname = "BattleAlert" ] ; then
	    delfile=$direc"/"$file"/Build/Products"
	    if [ -d "$delfile" ] ; then
		rm -rf $delfile
		echo "del "$delfile
	    fi	
	fi
done

