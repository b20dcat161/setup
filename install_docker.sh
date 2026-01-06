#!/bin/bash

set -e

echo "[*] Phát hiện hệ điều hành..."
if ! grep -qi kali /etc/os-release; then
    echo "[!] Script này CHỈ dành cho Kali Linux"
    exit 1
fi

echo "[*] Gỡ Docker cũ (nếu có)..."
sudo apt-get remove -y \
    docker docker-engine docker.io containerd runc docker-compose || true

echo "[*] Dọn repo Docker upstream sai (nếu tồn tại)..."
sudo rm -f /etc/apt/sources.list.d/docker.list
sudo rm -f /etc/apt/keyrings/docker.gpg

echo "[*] Cập nhật hệ thống..."
sudo apt update

echo "[*] Cài Docker từ repo chính thức của Kali..."
sudo apt install -y docker.io docker-compose-plugin

echo "[*] Enable & start Docker service..."
sudo systemctl enable docker --now

echo "[*] Thêm user hiện tại vào group docker..."
sudo usermod -aG docker $USER

echo "[✓] Hoàn tất cài Docker trên Kali!"
echo "👉 Logout/login lại hoặc chạy: newgrp docker"
echo "👉 Kiểm tra:"
echo "   docker --version"
echo "   docker compose version"


# fix nếu kẹt
# sudo dpkg --configure -a