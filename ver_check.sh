#!/bin/bash

apk_link=$XAPK_LINK
user_agent=$USER_AGENT

headers=$(wget -q -S -U "$user_agent" --start-pos 999999999 "$apk_link" 2>&1)

xapk_name=${headers##*=}

apk_version=${xapk_name%_*};apk_version=${apk_version##*_}

LATEST_TAG="$(git describe --tags "$(git rev-list --tags --max-count=1)")"

echo "APK_VERSION=$apk_version" >> "$GITHUB_ENV"

echo "Latest tag: $LATEST_TAG"
echo "Latest app version: $apk_version"

test "$LATEST_TAG" != "$apk_version" 






