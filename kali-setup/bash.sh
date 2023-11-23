#!/bin/bash

# Install Vivaldi
echo "Installing Vivaldi"
wget -O /tmp/vivaldi.deb 'https://downloads.vivaldi.com/stable/vivaldi-stable_6.2.3105.43-1_amd64.deb'
sudo dpkg -i /tmp/vivaldi.deb
sudo apt --fix-broken install -y
rm /tmp/vivaldi.deb

# Update and add necessary packages
echo "Installing Packages"
sudo apt update
sudo apt install -y terminator gedit python3-pip vim-gtk3 vivaldi-stable

# Install VSCode
echo "Installing VSCode"
wget -O /tmp/code.deb "https://update.code.visualstudio.com/latest/linux-deb-x64/stable"
sudo dpkg -i /tmp/code.deb
rm /tmp/code.deb

# Setup Rust and Rust tools
echo "Installing Rust and Rust tools"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash -s -- -y
~/.cargo/bin/cargo install rustscan
~/.cargo/bin/cargo install feroxbuster

# Setup fonts and Seclists
echo "Creating Scripts folder"
mkdir ~/Scripts
echo "Downloading SecLists"
git clone https://github.com/danielmiessler/SecLists ~/Scripts/SecLists

# Install dependencies
echo "Installing dependencies"
sudo apt update
sudo apt install -y \
    ca-certificates
    curl
    gnupg
    lsb-release

echo "Adding Docker source"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - 

sudo add-apt-repository "https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

echo "Installing Docker Engine"
sudo apt update && sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

echo "Adding user to docker group"
sudo gpasswd -a $USER docker

echo "Docker is installed; log out and log in to run Docker without sudo!"

exit 0