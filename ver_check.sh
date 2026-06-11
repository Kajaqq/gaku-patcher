#!/bin/bash

apk_version=$(python play_ver_check/app.py)

LATEST_TAG="$(git tag --sort=-v:refname | head -n 1)"

GAME_FILE_BASE=Gaku_$apk_version

echo "Latest tag: $LATEST_TAG"
echo "Latest app version: $apk_version"

if [ "$LATEST_TAG" != "$apk_version" ]
then
  echo "New version detected. Proceeding."
    {
    echo "continue=true"
    echo "apk_version=$apk_version"
    echo "game_file_base=$GAME_FILE_BASE"
    echo "game_apk_name=$GAME_FILE_BASE.apk"
    echo "game_cloned_name=${GAME_FILE_BASE}_cloned.apk"
    } >> "$GITHUB_OUTPUT"
else
    echo "No new version found. Stopping gracefully."
    # Set the output variable to 'false' to signal a stop
    echo "continue=false" >> "$GITHUB_OUTPUT"
fi
