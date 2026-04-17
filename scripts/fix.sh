#!/bin/bash

DIR="$HOME/.local/share/morg"
TEMP="$DIR/temp"
FILE="$TEMP/album_artist.txt"

norm() {
    echo "$1" | tr '[:upper:]' '[:lower:]' | xargs
}

[[ ! -f "$FILE" ]] && {
    echo "Error: album_artist.txt not found"
    exit 1
}

echo "Fixing album_artist.txt..."

tmp_file="$TEMP/tmp.txt"
> "$tmp_file"

declare -A seen

while IFS= read -r line; do
    [[ -z "$line" ]] && continue

    if [[ "$line" == *":"* ]]; then
        original="${line%%:*}"
        normalized="${line#*:}"
    else
        original="$line"
        normalized=$(norm "$line")
    fi

    # garantir consistência real
    normalized=$(norm "$normalized")

    key="$original:$normalized"

    if [[ -z "${seen[$key]}" ]]; then
        seen["$key"]=1
        echo "$key" >> "$tmp_file"
    fi

done < "$FILE"

mv "$tmp_file" "$FILE"

echo "Fix complete."