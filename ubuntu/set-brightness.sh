#!/usr/bin/env bash
ROOTFOLDER="/sys/class/backlight/intel_backlight"
MAX="$(cat "${ROOTFOLDER}/max_brightness")"
CURRENT="$(cat "${ROOTFOLDER}/brightness")"
MIN=10
NEW=$1
if (( NEW > MAX )); then
    NEW=$MAX
    echo "NEW gt MAX"
fi
if (( NEW < MIN )); then
    NEW=$MIN
    echo "NEW lt MIN"
fi
echo $NEW


