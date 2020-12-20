#!/bin/bash

#write udev rule to disable touch on main monitor
cd /etc/udev/rules.d
sudo touch 71-touchdisable.rules
echo 'ACTION=="add", SUBSYSTEM=="usb", ATTR{idProduct}=="2316",ATTR{idVendor}=="2149", ATTR{authorized}="0"' | sudo tee -a 71-touchdisable.rules
sudo udevadm control --reload-rules && udevadm trigger
cd ~/'Fresh start'
read -p "plugin external display USB hub, and press enter"

#set theme to dark mode -not sudo
#ls -d /usr/share/themes/* |xargs -L 1 basename
echo "set theme to dark mode"
gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'

#Set walpaper
echo "changing walpaper"
gsettings set org.gnome.desktop.background picture-uri ~/fresh-start/CoalFujiSnow.png

#Remove dock
echo "removing dock"
sudo apt remove gnome-shell-extension-ubuntu-dock -y

#set primary display to hdmi-out
echo "set primary display to HDMI"
xrandr --output HDMI-1 --primary --left-of eDP-1

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
echo "apt install vlc"
sudo apt install vlc -y
echo "apt install steam"
sudo apt install steam -y
echo "apt install git"
sudo apt install git -y
echo "apt install libreoffice-gnome libreoffice"
sudo apt install libreoffice-gnome libreoffice -y
echo "install adb"
sudo apt install adb
echo "install transmission"
sudo apt install transmission

#snap installs
echo "snap install typora"
sudo snap install typora
echo "snap install discord"
sudo snap install discord
echo "snap install spotify"	
sudo snap install spotify
echo "snap install chromium"
sudo snap install chromium


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
git clone https://github.com/Tudmotu/gnome-shell-extension-clipboard-indicator.git ~/.local/share/gnome-shell/extensions/clipboard-indicator@tudmotu.com
cd ~/'Fresh start'

#remove firefox, because it is bad
sudo apt remove --purge firefox -y


#install youtube Downloader
echo "installing youtube downloader"
sudo wget https://yt-dl.org/downloads/latest/youtube-dl -O /usr/local/bin/youtube-dl
sudo chmod a+rx /usr/local/bin/youtube-dl
sudo apt install ffmpeg -y #ffmpeg allows youtube-dl to concatenate audio and video files for the best quality downloads

#Add favourites to dock
echo "addiing favourites to dock"
dconf write /org/gnome/shell/favorite-apps "['chromium_chromium.desktop', 'spotify_spotify.desktop', 'org.gnome.Nautilus.desktop', 'steam.desktop', 'discord_discord.desktop', 'typora_typora.desktop']"


#write files for extra commands and ensure they are excecutable with chmod
cp ~/fresh-start/custom-commands.sh ~/.custom-commands.sh
sudo chmod +x ~/.custom-commands.sh
cp ~/fresh-start/videohammer.sh ~/.videohammer.sh
sudo chmod +x ~/.videohammer.sh
cp ~/fresh-start/maintenance.sh ~/.cfu.sh
sudo chmod +x ~/.cfu.sh

#sets custom commands file link in bashrc file
echo "#custom sources" | sudo tee -a ~/.bashrc
echo "source ~/.custom-commands.sh" | sudo tee -a ~/.bashrc

#reboot to complete installation
read -p "plug out fresh-start and press enter"

#enable extensions
gnome-extensions enable remove-dropdown-arrows@mpdeimos.com
gnome-extensions enable sound-output-device-chooser@kgshank.net
gnome-extensions enable clipboard-indicator@tudmotu.com

sudo reboot

