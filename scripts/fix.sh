#!/bin/bash

DIR="$HOME/.local/lib/morg"
TEMP="$DIR/temp"
FILE="$TEMP/album_artist.txt"

norm() {
    echo "$1" | tr '[:upper:]' '[:lower:]' | xargs
}

if [[ ! -f "$FILE" ]]; then
    echo "Error: album_artist.txt not found"
    exit 1
fi

echo "Fixing album_artist.txt..."

tmp_file="$TEMP/tmp.txt"
> "$tmp_file"

declare -A seen

while IFS= read -r line; do
    [ -z "$line" ] && continue

    # separar partes
    original="${line%%:*}"
    
    # se já tem formato correto
    if [[ "$line" == *":"* ]]; then
        normalized="${line#*:}"
    else
        normalized=$(norm "$original")
    fi

    # garantir consistência
    normalized=$(norm "$original")

    key="$original:$normalized"

    # remover duplicados corretamente (em memória)
    if [[ -z "${seen[$key]}" ]]; then
        seen["$key"]=1
        echo "$key" >> "$tmp_file"
    fi

done < "$FILE"

# ordenar e substituir
sort -u "$tmp_file" > "$FILE"

rm "$tmp_file"

echo "Fix complete."