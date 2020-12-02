#!/bin/bash

#write udev rule for touch disable
cd /etc/udev/rules.d
sudo touch 71-touchdisable.rules
echo 'ACTION=="add", SUBSYSTEM=="usb", ATTR{idProduct}=="2316",ATTR{idVendor}=="2149", ATTR{authorized}="0"' | sudo tee -a 71-touchdisable.rules
sudo udevadm control --reload-rules && udevadm trigger
cd ~/'Fresh start'
read -p "plugin external display, and press enter"

#update repository
echo "sudo update and upgrade"
sudo apt-get update
sudo apt-get upgrade -y
sudo apt autoremove -y
sudo snap refresh

#Open charge threshold from BAT0
#sudo xdg-open /sys/class/power_supply/BAT0/charge_control_end_thhreshold


#install software and tweaks
#read -p "install software?" 
echo "...installing software"
echo "snap install chromium"
sudo snap install chromium
echo "apt install vlc"
sudo apt install vlc -y
echo "snap install spotify"	
sudo snap install spotify
echo "apt install steam"
sudo apt install steam -y
echo "snap install discord"
sudo snap install discord
echo "apt install git"
sudo apt install git -y
echo "snap install typora"
snap install typora
#install tweaks
#read -p "installing tweaks"
echo "apt install gnome-tweaks"
sudo apt install gnome-tweaks -y

#Install extensions
echo "apt install gnome-shell-extension-remove-dropdown-arrows"
sudo apt install gnome-shell-extension-remove-dropdown-arrows -y
echo "installing sound device chooser"
mkdir ~/.local/share/gnome-shell/extensions
cd ~/.local/share/gnome-shell/extensions
git clone https://github.com/kgshank/gse-sound-output-device-chooser.git ~/.local/share/gnome-shell/extensions
cd ~/'Fresh start'

#install youtube Downloader
echo "installing youtube downloader"
sudo wget https://yt-dl.org/downloads/latest/youtube-dl -O /usr/local/bin/youtube-dl
sudo chmod a+rx /usr/local/bin/youtube-dl
#Add favourites to dock
echo "addiing favourites to dock"
dconf write /org/gnome/shell/favorite-apps "['chromium_chromium.desktop', 'spotify_spotify.desktop', 'org.gnome.Nautilus.desktop', 'steam.desktop', 'discord_discord.desktop', 'typora_typora.desktop']"

#Set walpaper
echo "changing walpaper"
sudo cp CoalFujiSnow.png /home/jason/Pictures
gsettings set org.gnome.desktop.background picture-uri "file:///home/jason/Pictures/CoalFujiSnow.png"

#set theme to dark mode
echo "set theme to dark mode"
sudo gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'

#set primary display to hdmi-out
echo "set primary display to HDMI"
xrandr --output HDMI-1 --primary --left-of eDP-1


#Remove dock
echo "removing dock"
sudo apt remove gnome-shell-extension-ubuntu-dock -y
