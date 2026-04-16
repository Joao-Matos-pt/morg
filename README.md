# 🎧 MORG

MORG is a Bash music organizer that automatically sorts your music library using metadata (ID3 tags).

---

## 🚀 Features

- Organizes music by **Album Artist**
- Falls back to **Artist** if missing
- Unknown artists go to `Others/`
- Detects duplicates using SHA256 hashes
- Includes `refresh` and `fix` tools

---

## 📂 Structure

Music/
  Artist/
    Album/
      song.mp3

Others/

---

## ⚙️ Installation

git clone https://github.com/YOUR_USERNAME/morg.git
cd morg
./install.sh

---

## 🎧 Usage

### Organize music

morg organize Music

### Refresh library

morg refresh Music

### Fix internal data

morg fix

---

## 🧠 Requirements

- ffmpeg (ffprobe)
- coreutils (sha256sum)

Install on Ubuntu:

sudo apt install ffmpeg

---

## ⚠️ Warning

Do not run on system directories like / or /home.

Test first on a music folder.

---