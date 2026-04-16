#!/bin/bash

# ========================
# CONFIG
# ========================
VERSION="0.67"

DIR="$HOME/.local/lib/morg"
SCRIPTS="$DIR/scripts"
TEMP="$DIR/temp"

# ========================
# UTILS
# ========================

check_duplicate() {
    local file="$1"

    local hash
    hash=$(sha256sum "$file" | cut -d' ' -f1)

    if grep -q "$hash" "$TEMP/hashes.txt"; then
        echo "Duplicate skipped: $file"
        mkdir -p "$TEMP/duplicates"
        mv "$file" "$TEMP/duplicates/"
        return 1
    fi

    echo "$hash|$file" >> "$TEMP/hashes.txt"
    return 0
}

norm() {
    echo "$1" | tr '[:upper:]' '[:lower:]' | xargs
}

die() {
    echo "Error: $1"
    exit 1
}

# ========================
# VALIDATION
# ========================

resolve_dest() {
    DEST="$(cd "${1:-.}" 2>/dev/null && pwd)" || die "Invalid directory"
}

validate_safe_path() {
    case "$DEST" in
        "/"|"$HOME"|"/home")
            die "Unsafe directory"
            ;;
    esac
}

# ========================
# STEPS
# ========================

step_prepare() {
    mkdir -p "$TEMP"
    touch "$TEMP/album_artist.txt"
    touch "$TEMP/hashes.txt"
    mkdir -p "$TEMP/duplicates"
}

step_process_others() {
    if [[ -d "$DEST/Others" ]]; then
        echo "Processing Others..."
        "$SCRIPTS/moveOut.sh" "$DEST/Others"
    fi
}

step_organize() {
    cd "$DEST" || exit

    shopt -s nullglob

    for f in *.mp3 *.opus *.flac *.m4a; do

        check_duplicate "$f" || continue

        album_artist=$(ffprobe -v quiet -show_format -show_streams "$f"\
        | grep TAG:album_artist= \
        | cut -d'=' -f2)


        norm_album_artist=$(norm "$album_artist")

        if [[ -n "$album_artist" ]]; then

            if ! grep -Fxq "$album_artist:$norm_album_artist" "$TEMP/album_artist.txt"; then
                echo "$album_artist:$norm_album_artist" >> "$TEMP/album_artist.txt"
            fi

            mkdir -p "$album_artist"
            mv "$f" "$album_artist/"
            echo "Moved: $f -> $album_artist"

        else
            mkdir -p "Others"
            mv "$f" "Others/"
            echo "No album artist: $f"
        fi
    done
}

# ========================
# COMMANDS
# ========================

cmd_organize() {
    resolve_dest "$2"
    validate_safe_path
    step_prepare
    step_process_others
    step_organize
}

cmd_refresh() {
    resolve_dest "$2"
    validate_safe_path
    step_process_others
    step_organize
}

cmd_fix() {
    "$SCRIPTS/fix.sh"
}

# ========================
# MAIN
# ========================

main() {
    case "$1" in
        organize)
            cmd_organize "$@"
            ;;
        refresh)
            cmd_refresh "$@"
            ;;
        fix)
            cmd_fix
            ;;
        --version)
            echo "morg version:$VERSION"
            ;;
        *)
            echo "Usage: morg {organize|refresh|fix} [directory]"
            exit 1
            ;;
    esac
}

main "$@"