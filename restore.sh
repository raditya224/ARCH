#!/bin/bash

# Pastikan script berhenti jika ada error
set -e

echo "🚀 Memulai Ritual Pemulihan Arch..."

# 1. Update sistem & Install Git/Base-devel
echo "📦 Menginstall paket dasar..."
sudo pacman -Syu --needed git base-devel --noconfirm

# 2. Install Paket dari Official Repo
if [ -f "pkglist.txt" ]; then
    echo "📥 Menginstall aplikasi dari Pacman..."
    sudo pacman -S --needed - < pkglist.txt --noconfirm
else
    echo "⚠️ pkglist.txt tidak ditemukan!"
fi

# 3. Setup Yay (AUR Helper)
if ! command -v yay &> /dev/null; then
    echo "🏗️ Membangun yay..."
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay && makepkg -si --noconfirm
    cd -
fi

# 4. Install Paket dari AUR
if [ -f "aurlist.txt" ]; then
    echo "🌌 Menginstall aplikasi dari AUR..."
    yay -S --needed - < aurlist.txt --noconfirm
else
    echo "⚠️ aurlist.txt tidak ditemukan!"
fi

echo "✅ Ritual Selesai! Sistem kamu sudah kembali 'bernyawa'."
