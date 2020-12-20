#!/bin/sh

clear

echo '.............starting update sequence.............'
        killall snap-store
        
        echo 'snap refresh'
        sudo snap refresh
        echo 'snap refresh complete
        VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV'
        
        echo 'apt update'
        sudo apt update
        echo 'apt update complete
        VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV'
        
        echo 'apt upgrade'
        sudo apt upgrade -y
        echo 'apt upgrade complete
        VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV'
        
        echo 'apt autoclean'
        sudo apt autoclean -y
        echo 'apt autoclean complete
        VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV'
        
        echo 'apt autoremove'
        sudo apt autoremove -y
        echo 'apt autoremove
        VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV'
        
        echo '
        
        '
        
        echo '.............update sequence complete.............
        
        
        
        '
        
read -p "Please select exit condition and press [Enter].
[1] Reboot
[2] Exit
" term
	while [ $term != "1" ] && [ $term != "2" ]
	do
	clear
	echo "$term not a valid option!"
read -p "Please select exit condition and press [Enter].
[1] Reboot
[2] Exit
" term
	done

	if [ $term = "1" ]; then
		sudo reboot
	fi
	
	if [ $term = "2" ]; then
		exit 1
	fi
