#!/bin/bash

LOCALIFY_CN_VER=$(curl -s https://api.github.com/repos/chinosk6/gakuen-imas-localify/releases | jq -r 'map(select(.prerelease)) | .[0].tag_name')
LOCALIFY_CN_LINK=https://github.com/chinosk6/gakuen-imas-localify/releases/download/$LOCALIFY_CN_VER/app-release.apk
LOCALIFY_CN_NAME=LocalifyCN.apk
LOCALIFY_EN_LINK=https://gitea.tendokyu.moe/Maji/gakumas-localify-en/releases/download/latest/Localify.apk
LOCALIFY_EN_NAME=Localify.apk

aria2c -j16 "$LOCALIFY_CN_LINK" -o $LOCALIFY_CN_NAME
aria2c -j16 $LOCALIFY_EN_LINK -o $LOCALIFY_EN_NAME
aria2c -j16 "$GAME_XAPK_LINK" -o "$GAME_XAPK_NAME"

java -jar APKEditor.jar m -i "$GAME_XAPK_NAME" -o "$GAME_APK_NAME"

echo "LOCALIFY_CN_NAME=$LOCALIFY_CN_NAME" >> "$GITHUB_ENV"
echo "LOCALIFY_EN_NAME=$LOCALIFY_EN_NAME" >> "$GITHUB_ENV"



