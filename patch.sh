#!/bin/bash

var=$(python ./get_gakumas_xapk.py)

apk_version=${var%https*}

apk_link=${var#$apk_version*}

file=Gaku_$apk_version

xapk_name=$file.xapk

apk_name=$file.apk

aria2c -j16 $apk_link -o $xapk_name

java -jar APKEditor.jar m -i $xapk_name -o $apk_name

java -jar lspatch.jar -l 2 --manager $apk_name

rm -f $xapk_name $apk_name 

patched_apk=$(find *patched.apk)

echo "PATCHED_APK=$patched_apk" >> "$GITHUB_ENV"
echo "APK_VERSION=$apk_version" >> "$GITHUB_ENV"
