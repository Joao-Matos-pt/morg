#!/bin/bash

set -e

# ========================
# CONFIG
# ========================

BIN="/usr/local/bin/morg"
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

# inicial state
echo "album_artist" > "$DATA/temp/mode"

# ========================
# COPY FILES
# ========================

echo "Copying files..."

sudo cp main.sh "$LIB/main.sh"
sudo cp scripts/*.sh "$LIB/scripts/"

# wrapper CLI
sudo tee "$BIN" > /dev/null <<EOF
#!/bin/bash
exec /usr/local/lib/morg/main.sh "\$@"
EOF

# ========================
# PERMISSIONS
# ========================

sudo chmod +x "$LIB/main.sh"
sudo chmod +x "$LIB/scripts/"*.sh
sudo chmod +x "$BIN"

# ========================
# DONE
# ========================

echo "Installation complete!"
echo "Run with: morg"