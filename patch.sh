#!/bin/bash

apk_link=$XAPK_LINK

file=Gaku_$APK_VERSION

xapk_name=$file.xapk
apk_name=$file.apk

aria2c -j16 $apk_link -o $xapk_name

java -jar APKEditor.jar m -i $xapk_name -o $apk_name

java -jar lspatch.jar -l 2 --manager $apk_name

java -jar lspatch2.jar $apk_name -d -m module.apk

rm -f $xapk_name $apk_name 

# patched_apk=$(find *430-lspatched.apk)
# embed_apk=$(find *426-lspatched.apk)

# mv $embed_apk "$file"_embedded.apk

# embed_apk=$(find *_embedded.apk)

# echo "PATCHED_APK=$patched_apk" >> "$GITHUB_ENV"
# echo "EMBED_APK=$embed_apk" >> "$GITHUB_ENV"
