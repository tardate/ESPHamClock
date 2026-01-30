#!/usr/bin/env bash

function download-and-check-in() {
    local version="$1"
    local url="https://www.clearskyinstitute.com/ham/HamClock/ESPHamClock-V${version}.zip"
    local filename=$(basename "$url")

    wget "$url"
    if [ -f "$filename" ]; then
        rm -fR src
        unzip -o "$filename"
        mv ESPHamClock src
        git add src
        git commit -m "Add $filename"
        git tag -a "${version}" -m "${version}"
        rm -f "$filename"
    else
        echo "Failed to download $filename"
    fi
}

download-and-check-in "3.10"
download-and-check-in "4.13"
download-and-check-in "4.14"
download-and-check-in "4.15"
download-and-check-in "4.16"
download-and-check-in "4.17"
download-and-check-in "4.18"
download-and-check-in "4.19"
download-and-check-in "4.20"
download-and-check-in "4.21"
download-and-check-in "4.22"
