#!/bin/bash

get_gh_latest() {
    local repo="$1"
    local ext="${2:-.apk}"

    curl -s "https://api.github.com/repos/${repo}/releases" | \
      jq -r --arg ext "$ext" '.[0].assets[] | select(.name | ascii_downcase | endswith($ext | ascii_downcase)) | .browser_download_url'
}

LOCALIFY_CN_LINK=$(get_gh_latest "chinosk6/gakuen-imas-localify")
LOCALIFY_CN_NAME=LocalifyCN.apk

LOCALIFY_EN_LINK=https://gitea.tendokyu.moe/Maji/gakumas-localify-en/releases/download/latest/Localify.apk
LOCALIFY_EN_NAME=Localify.apk

APKEEP_LINK=https://github.com/EFForg/apkeep/releases/latest/download/apkeep-x86_64-unknown-linux-gnu
APKEEP_NAME=apkeep

APKEDITOR_LINK=$(get_gh_latest "REAndroid/APKEditor" ".jar")
APKEDITOR_NAME=APKEditor.jar

LSPATCH_LINK=$(get_gh_latest "JingMatrix/LSPatch" "-release.jar")
LSPATCH_NAME=lspatch.jar


aria2c -x4 "$LOCALIFY_CN_LINK" -o $LOCALIFY_CN_NAME
aria2c -x4 "$LOCALIFY_EN_LINK" -o $LOCALIFY_EN_NAME

aria2c -x4 "$APKEEP_LINK" -o $APKEEP_NAME
aria2c -x4 "$APKEDITOR_LINK" -o $APKEDITOR_NAME
aria2c -x4 "$LSPATCH_LINK" -o $LSPATCH_NAME

chmod +x $APKEEP_NAME

echo "LOCALIFY_CN_NAME=$LOCALIFY_CN_NAME" >> "$GITHUB_ENV"
echo "LOCALIFY_EN_NAME=$LOCALIFY_EN_NAME" >> "$GITHUB_ENV"

