#!/bin/bash

# CONFIG
OPTIONS=locale=jp,timezone=UTC+9,split_apk=1,include_additional_files=true
APP_ID=$1

./apkeep -a "$APP_ID" -d google-play -o $OPTIONS -e "$PLAY_EMAIL" -t "$AAS_TOKEN" .