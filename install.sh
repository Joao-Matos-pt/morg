#!/bin/bash

set -e

echo "Installing MORG from git..."

# ========================
# DEPENDENCIES
# ========================

if ! command -v ffprobe >/dev/null 2>&1; then
    echo "Installing ffmpeg..."
    sudo apt update
    sudo apt install -y ffmpeg
fi

# ========================
# PATHS
# ========================

BASE="$HOME/.local/lib/morg"
BIN="$HOME/.local/bin"
SCRIPTS="$BASE/scripts"
TEMP="$BASE/temp"

# ========================
# CREATE DIRS
# ========================

mkdir -p "$SCRIPTS"
mkdir -p "$TEMP"
mkdir -p "$BIN"

# ========================
# COPY FROM REPO
# ========================

cp ./main.sh "$BASE/main.sh"
cp ./scripts/* "$SCRIPTS/"

chmod +x "$BASE/main.sh"
chmod +x "$SCRIPTS/"*

# ========================
# CREATE COMMAND
# ========================

cat > "$BIN/morg" << 'EOF'
#!/bin/bash
bash "$HOME/.local/lib/morg/main.sh" "$@"
EOF

chmod +x "$BIN/morg"

# ========================
# PATH CHECK
# ========================

if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    echo "Add this to your shell config:"
    echo 'export PATH="$HOME/.local/bin:$PATH"'
fi

echo "MORG installed successfully!"