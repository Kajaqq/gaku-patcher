#!/bin/bash

LOCALIFY_CN_LINK=$(curl -s https://api.github.com/repos/chinosk6/gakuen-imas-localify/releases | jq -r '.[0].assets[] | select(.name | endswith(".apk")) | .browser_download_url')
LOCALIFY_CN_NAME=LocalifyCN.apk
LOCALIFY_EN_LINK=https://gitea.tendokyu.moe/Maji/gakumas-localify-en/releases/download/latest/Localify.apk
LOCALIFY_EN_NAME=Localify.apk

aria2c -j16 "$LOCALIFY_CN_LINK" -o $LOCALIFY_CN_NAME
aria2c -j16 $LOCALIFY_EN_LINK -o $LOCALIFY_EN_NAME
aria2c -j16 "$GAME_XAPK_LINK" -o "$GAME_XAPK_NAME"

java -jar APKEditor.jar m -i "$GAME_XAPK_NAME" -o "$GAME_APK_NAME"

echo "LOCALIFY_CN_NAME=$LOCALIFY_CN_NAME" >> "$GITHUB_ENV"
echo "LOCALIFY_EN_NAME=$LOCALIFY_EN_NAME" >> "$GITHUB_ENV"



