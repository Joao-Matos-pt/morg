🎵 MORG — Music Organizer

MORG is a CLI tool written in Bash that automatically organizes music files
based on their metadata (ID3 tags).

--------------------------------------------------
🚀 Features
--------------------------------------------------

- Organizes music by:
    • album_artist
    • artist/album

- Smart fallback system:
    • Uses artist if album_artist is missing
    • Attempts to detect artist from filename

- Duplicate detection using hashing (sha256)
- Automatic reprocessing of "Others" folder
- Name normalization (lowercase, trim)
- Clean and consistent directory structure

--------------------------------------------------
📦 Structure
--------------------------------------------------

Default mode (album_artist):

```text
Music/
├── Juice WRLD/
├── Travis Scott/
└── Others/
```

Artist mode:

```text
Music/
└── Juice WRLD/
    ├── Goodbye & Good Riddance/
    └── Legends Never Die/
```
--------------------------------------------------
⚙️ Installation
--------------------------------------------------

git clone https://github.com/Joao-Matos-pt/morg.git

cd morg

chmod +x install.sh

./install.sh

--------------------------------------------------
🧠 Dependencies
--------------------------------------------------

- ffprobe (from ffmpeg)
- sha256sum (coreutils)

Ubuntu:
sudo apt install ffmpeg coreutils

--------------------------------------------------
🧪 Usage
--------------------------------------------------

Organize (default mode):
```bash
morg organize
```

Organize by artist:
```bash
morg organize --by artist
```

Organize specific directory:
```bash
morg organize Music
```

Refresh (reprocess "Others"):
```bash
morg refresh
```

> Automatically uses the last selected mode

Fix internal files:
```bash
morg fix
```

--------------------------------------------------
🧹 Uninstall
--------------------------------------------------

./uninstall.sh

--------------------------------------------------
🧠 How it works
--------------------------------------------------

1. Reads metadata using ffprobe
2. Normalizes names (lowercase, trim)
3. Moves files into structured directories
4. Stores artist mapping
5. Reprocesses problematic files (Others)
6. Avoids duplicates using hashing

--------------------------------------------------
⚠️ Safety
--------------------------------------------------

- Prevents execution in unsafe directories (/, $HOME)
- Sanitizes folder names
- Confirms before deleting user data

--------------------------------------------------
📌 Status
--------------------------------------------------

Work in progress — continuous improvements

--------------------------------------------------
💡 Future Ideas
--------------------------------------------------

- GUI interface
- Config file (~/.config/morg)
- Better duplicate detection (bitrate, quality)
- Music API integration

--------------------------------------------------
👤 Author
--------------------------------------------------

Developed by João Matos