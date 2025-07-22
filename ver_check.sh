#!/bin/bash

headers=$(wget -q -S -U "$USER_AGENT" --start-pos 999999999 "$GAME_XAPK_LINK" 2>&1)

xapk_name=${headers##*=}

apk_version=${xapk_name%_*};apk_version=${apk_version##*_}

LATEST_TAG="$(git describe --tags "$(git rev-list --tags --max-count=1)")"

GAME_FILE_BASE=Gaku_$apk_version

echo "Latest tag: $LATEST_TAG"
echo "Latest app version: $apk_version"

if [ "$LATEST_TAG" != "$apk_version" ] 
then
    {
    echo "APK_VERSION=$apk_version";
    echo "GAME_FILE_BASE=$GAME_FILE_BASE";
    echo "GAME_XAPK_NAME=$GAME_FILE_BASE.xapk";
    echo "GAME_APK_NAME=$GAME_FILE_BASE.apk";
    echo "GAME_CLONED_NAME=""$GAME_FILE_BASE""_cloned.apk";
    } >> "$GITHUB_ENV"
else
    return 1
fi


