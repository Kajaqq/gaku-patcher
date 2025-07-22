#!/bin/bash

GAME_EMBEDDED_BASE="$GAME_FILE_BASE"_embedded
GAME_EMBEDDED_OLD="$GAME_EMBEDDED_BASE"_old.apk
GAME_EMBEDDED_APK="$GAME_EMBEDDED_BASE".apk
GAME_EMBEDDED_CLONED="$GAME_EMBEDDED_BASE"_cloned.apk

java -jar lspatch.jar -l 2 --manager "$GAME_APK_NAME" -o ls_patched

java -jar lspatch_embed.jar "$GAME_APK_NAME" -m "$LOCALIFY_EN_NAME" -o localify --force
java -jar lspatch_embed.jar "$GAME_APK_NAME" -m "$LOCALIFY_CN_NAME" -o localify_cn --force

patched_apk=$(find ./ls_patched/*.apk)
embed_apk=$(find ./localify/*.apk)
embed_apk_cn=$(find ./localify_cn/*.apk)

mv "$embed_apk" ./"$GAME_EMBEDDED_APK"
mv "$embed_apk_cn" ./"$GAME_EMBEDDED_OLD"

{
    echo "PATCHED_APK=$patched_apk";
    echo "EMBED_APK=$GAME_EMBEDDED_APK";
    echo "EMBED_APK_CN=$GAME_EMBEDDED_OLD";} >> "$GITHUB_ENV"

if [ -f "$GAME_CLONED_NAME" ] 
then
java -jar lspatch_embed.jar "$GAME_APK_NAME" -m "$LOCALIFY_EN_NAME" -o localify_cloned --force
embed_apk_cloned=$(find ./localify_cloned/*.apk)
mv "$embed_apk_cloned" ./"$GAME_EMBEDDED_CLONED"
echo "EMBED_APK_CLONED=$GAME_EMBEDDED_CLONED" >> "$GITHUB_ENV"
fi