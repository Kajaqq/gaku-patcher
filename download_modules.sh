#!/bin/bash

get_gh_latest() {
    curl -s https://api.github.com/repos/$1/releases | jq -r '.[0].assets[] | select(.name | ascii_downcase | endswith(".apk")) | .browser_download_url'
}

LOCALIFY_CN_LINK=$(get_gh_latest chinosk6/gakuen-imas-localify)
LOCALIFY_CN_NAME=LocalifyCN.apk

LOCALIFY_EN_LINK=https://gitea.tendokyu.moe/Maji/gakumas-localify-en/releases/download/latest/Localify.apk
LOCALIFY_EN_NAME=Localify.apk

APKEEP_LINK=https://github.com/EFForg/apkeep/releases/latest/download/apkeep-x86_64-unknown-linux-gnu
APKEEP_NAME=apkeep

APKEDITOR_LINK=https://github.com/REAndroid/APKEditor/releases/download/V1.4.9/APKEditor-1.4.9.jar
APKEDITOR_NAME=APKEditor.jar

aria2c -x4 "$LOCALIFY_CN_LINK" -o $LOCALIFY_CN_NAME
aria2c -x4 "$LOCALIFY_EN_LINK" -o $LOCALIFY_EN_NAME

aria2c -x4 "$APKEEP_LINK" -o $APKEEP_NAME
aria2c -x4 "$APKEDITOR_LINK" -o $APKEDITOR_NAME

chmod +x $APKEEP_NAME

echo "LOCALIFY_CN_NAME=$LOCALIFY_CN_NAME" >> "$GITHUB_ENV"
echo "LOCALIFY_EN_NAME=$LOCALIFY_EN_NAME" >> "$GITHUB_ENV"
