#!/bin/bash

var=$(python ./get_gakumas_xapk.py)

var_nospace=${var//[[:space:]]/}

apk_version=${var_nospace%https*}

apk_link=${var_nospace#$apk_version*}

file=Gakuen_iDOLM@STER_$apk_version

xapk_name=$file.xapk

apk_name=$file.apk

aria2c -j16 $apk_link -o $xapk_name

java -jar APKEditor.jar m -i $xapk_name -o $apk_name

java -jar lspatch.jar -l 2 --manager $apk_name

rm -f $xapk_name $apk_name $merged_apk

patched_apk=$(find *patched.apk)

echo FILE PATCHED, VERSION: $apk_version, PATCHED FILE NAME: $patched_apk