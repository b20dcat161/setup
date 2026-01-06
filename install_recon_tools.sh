#!/bin/bash

# This script installs common bug bounty reconnaissance tools on Kali Linux.

# Ensure the script is run as root
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root. Please use sudo." >&2
    exit 1
fi

echo "Updating package lists..."
apt update -y

echo "Upgrading installed packages..."
apt upgrade -y

echo "Installing essential dependencies..."
apt install -y git golang python3 python3-pip

# Install Go tools
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# Amass
echo "Installing Amass..."
apt install -y amass || go install -v github.com/owasp-amass/amass/v4/...@master

# Subfinder
echo "Installing Subfinder..."
apt install -y subfinder || go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest

# Assetfinder
echo "Installing Assetfinder..."
apt install -y assetfinder || go install -v github.com/tomnomnom/assetfinder@latest

# Nmap (usually pre-installed)
echo "Installing Nmap..."
apt install -y nmap

# Gobuster
echo "Installing Gobuster..."
apt install -y gobuster || go install github.com/OJ/gobuster/v3@latest

# FFuf
echo "Installing FFuf..."
apt install -y ffuf || go install github.com/ffuf/ffuf@latest

# JSFinder
echo "Installing JSFinder..."
if [ ! -d "/opt/JSFinder" ]; then
    git clone https://github.com/Threezh1/JSFinder.git /opt/JSFinder
    pip3 install -r /opt/JSFinder/requirements.txt
else
    echo "JSFinder already exists. Skipping clone."
fi

# ParamSpider
echo "Installing ParamSpider..."
if [ ! -d "/opt/ParamSpider" ]; then
    git clone https://github.com/devanshbatham/ParamSpider.git /opt/ParamSpider
    pip3 install -r /opt/ParamSpider/requirements.txt
else
    echo "ParamSpider already exists. Skipping clone."
fi

# Recon-ng
echo "Installing Recon-ng..."
apt install -y recon-ng || \
if [ ! -d "/opt/recon-ng" ]; then
    git clone https://github.com/lanmaster53/recon-ng.git /opt/recon-ng
    pip3 install -r /opt/recon-ng/requirements.txt
else
    echo "Recon-ng already exists. Skipping clone."
fi

# Shodan CLI
echo "Installing Shodan CLI..."
pip3 install shodan

# testssl.sh
echo "Installing testssl.sh..."
if [ ! -d "/opt/testssl.sh" ]; then
    git clone --depth 1 https://github.com/drwetter/testssl.sh.git /opt/testssl.sh
else
    echo "testssl.sh already exists. Skipping clone."
fi

# Install SecLists (for wordlists)
echo "Installing SecLists..."
if [ ! -d "/opt/SecLists" ]; then
    git clone https://github.com/danielmiessler/SecLists.git /opt/SecLists
else
    echo "SecLists already exists. Skipping clone."
fi

echo "
Installation complete!"
echo "
Remember to configure Shodan CLI with your API key: shodan init <YOUR_API_KEY>"
echo "
Burp Suite Community Edition is usually pre-installed or can be downloaded from PortSwigger website."


