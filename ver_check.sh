#!/bin/bash

var=$(python ./get_gakumas_xapk.py)

apk_version=${var%https*}
LATEST_TAG=$(git for-each-ref refs/tags --sort=-refname:short --format='%(refname:short)' --count=1)

echo "APK_VERSION=$apk_version" >> "$GITHUB_ENV"

echo "Latest tag: $LATEST_TAG"
echo "Latest app version: $apk_version"

test $LATEST_TAG != $apk_version 
