#!/bin/bash

if [ $# -le 0 ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

DIRECTORY="$1"

if [[ ! -d "$DIRECTORY" ]]; then
    echo "Error: Directory not found"
    exit 1
fi

cd "$DIRECTORY" || exit

shopt -s nullglob

echo "Moving music files from '$DIRECTORY' to parent directory..."

for f in *.mp3 *.opus *.flac *.m4a; do
    echo "Moving: $f -> ../"
    mv -n "$f" ../
done

echo "Done."