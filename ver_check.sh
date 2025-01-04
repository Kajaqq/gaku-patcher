#!/bin/bash

var=$(python ./get_gakumas_xapk.py)

apk_version=${var%https*}

LATEST_SHA=$(git rev-list --tags --max-count=1)
[[ $LATEST_SHA ]] && LATEST_TAG=$(git describe --tags $LATEST_SHA)

echo "APK_VERSION=$apk_version" >> "$GITHUB_ENV"

echo "$LATEST_SHA"
echo "$LATEST_TAG"
echo "$apk_version"