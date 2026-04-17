#!/bin/bash

set -e

# ========================
# CONFIG
# ========================

BIN="/usr/local/bin"
LIB="/usr/local/lib/morg"
DATA="$HOME/.local/share/morg"

echo "Installing MORG..."

# ========================
# CHECK DEPENDENCIES
# ========================

command -v ffprobe >/dev/null 2>&1 || {
    echo "Error: ffprobe not found (install ffmpeg)"
    exit 1
}

command -v sha256sum >/dev/null 2>&1 || {
    echo "Error: sha256sum not found"
    exit 1
}

# ========================
# CREATE DIRECTORIES
# ========================

echo "Creating directories..."

sudo mkdir -p "$LIB/scripts"
mkdir -p "$DATA/temp"

# ========================
# COPY FILES
# ========================

echo "Copying files..."

# main script
sudo cp main.sh "$LIB/main.sh"

# internal scripts
sudo cp scripts/*.sh "$LIB/scripts/"

# wrapper (morg command)
sudo cp morg "$BIN/morg"

# ========================
# PERMISSIONS
# ========================

echo "Setting permissions..."

sudo chmod +x "$LIB/main.sh"
sudo chmod +x "$LIB/scripts/"*.sh
sudo chmod +x "$BIN/morg"

# ========================
# DONE
# ========================

echo "Installation complete!"
echo "Run with: morg"