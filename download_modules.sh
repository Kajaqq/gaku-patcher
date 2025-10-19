#!/bin/bash

# LOCALIFY_CN_LINK=$(curl -s https://api.github.com/repos/chinosk6/gakuen-imas-localify/releases | jq -r '.[0].assets[] | select(.name | endswith(".apk")) | .browser_download_url')
LOCALIFY_CN_LINK=https://github.com/chinosk6/gakuen-imas-localify/releases/download/v3.1.0/app-release.apk
LOCALIFY_CN_NAME=LocalifyCN.apk
LOCALIFY_EN_LINK=https://gitea.tendokyu.moe/Maji/gakumas-localify-en/releases/download/latest/Localify.apk
LOCALIFY_EN_NAME=Localify.apk

APKEEP_LINK=https://github.com/EFForg/apkeep/releases/latest/download/apkeep-x86_64-unknown-linux-gnu
APKEEP_NAME=apkeep

aria2c -j16 $LOCALIFY_CN_LINK -o $LOCALIFY_CN_NAME
aria2c -j16 $LOCALIFY_EN_LINK -o $LOCALIFY_EN_NAME

aria2c -j16 $APKEEP_LINK -o $APKEEP_NAME
chmod +x $APKEEP_NAME

echo "LOCALIFY_CN_NAME=$LOCALIFY_CN_NAME" >> "$GITHUB_ENV"
echo "LOCALIFY_EN_NAME=$LOCALIFY_EN_NAME" >> "$GITHUB_ENV"



