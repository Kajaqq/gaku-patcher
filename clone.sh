#!/bin/bash
APK_EXTRACT_DIR=Gaku_decompile_xml
OLD_PACKAGE_NAME="com.bandainamcoent.idolmaster_gakuen"
NEW_PACKAGE_NAME="com.bandainamcoent.idolmaster_gaku_en"

GAKUMAS_JP="学マス"
GAKUMAS_EN="Gakumas"
NAME_FILE="./$APK_EXTRACT_DIR/resources/package_1/res/values/strings.xml"

java -jar APKEditor.jar d -t xml -dex -i "$GAME_APK_NAME" -o $APK_EXTRACT_DIR

grep -rIl "$OLD_PACKAGE_NAME" ./$APK_EXTRACT_DIR | xargs sed -i "s/$OLD_PACKAGE_NAME/$NEW_PACKAGE_NAME/g"
sed -i "s/$GAKUMAS_JP/$GAKUMAS_EN/g" $NAME_FILE

java -jar APKEditor.jar b -i $APK_EXTRACT_DIR -o "$GAME_CLONED_NAME"
