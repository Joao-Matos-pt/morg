#!/bin/bash

set -e

BIN="/usr/local/bin/morg"
LIB="/usr/local/lib/morg"
DATA="$HOME/.local/share/morg"

echo "Uninstalling MORG..."

# ========================
# CHECK INSTALLATION
# ========================

if [[ ! -f "$BIN" && ! -d "$LIB" ]]; then
    echo "MORG does not seem to be installed."
    exit 1
fi

# ========================
# REMOVE BIN
# ========================

if [[ -f "$BIN" ]]; then
    echo "Removing executable..."
    sudo rm -f "$BIN"
fi

# ========================
# REMOVE LIB
# ========================

if [[ -d "$LIB" ]]; then
    echo "Removing library files..."
    sudo rm -rf "$LIB"
fi

# ========================
# DATA CONFIRMATION
# ========================

if [[ -d "$DATA" ]]; then
    echo
    read -p "Remove user data (~/.local/share/morg)? [y/N]: " choice
    case "$choice" in
        y|Y)
            rm -rf "$DATA"
            echo "User data removed."
            ;;
        *)
            echo "User data kept."
            ;;
    esac
fi

echo "Uninstall complete."