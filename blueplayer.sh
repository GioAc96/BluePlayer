#!/bin/bash
#Blueplayer, by Giorgio Acquati

BADDR="78_F8_82_6C_65_6B"
title="Unknown Title"
artist="Unknown Artist"
album="Unknown Album"
icon="$(pwd)/icon.ico"
bold=$(tput bold)
normal=$(tput sgr0)

updateTrackInfo() {
	#set all parameters to unknown
	title="Unknown Title"
	artist="Unknown Artist"
	album="Unknown Album"

	#parse track information
	output=$(dbus-send --print-reply --type=method_call --system --dest=org.bluez /org/bluez/hci0/dev_$BADDR/player0 org.freedesktop.DBus.Properties.Get string:org.bluez.MediaPlayer1 string:Track)
	while read -r line; do
   	if [[ $line == *'string "Album"'* ]]; then
   		read -r album
   	elif [[ $line == *'string "Title"'* ]]; then
   		read -r title
   	elif [[ $line == *'string "Artist"'* ]]; then
   		read -r artist
   	fi
	done <<< "$output"

	#trim strings
	album=$(echo $album | cut -d '"' -f 2 )
	title=$(echo $title | cut -d '"' -f 2 )
	artist=$(echo $artist | cut -d '"' -f 2 )
}

notifyTrackInfo() {
	pkill notify-osd
	notify-send --icon="$icon" "$title" "$artist - $album"
}
echoTrackInfo() {
	clear
	echo ${normal} Currently playing:
	echo ${bold}
	echo "    $title"
	#echo ----------------------------------------------------
	echo "    ${normal}by ${bold}$artist"
	echo "    ${normal}from ${bold}$album"
}


startNotifying() {

	updateTrackInfo
	echoTrackInfo


	gdbus monitor --system --dest org.bluez --object-path /org/bluez/hci0/dev_$BADDR/player0 |
	while read -r line; do
	 	if [[ $line == *"{'Status':"* ]]; then
 			if [[ $line == *"playing"* ]]; then
			updateTrackInfo
			notifyTrackInfo
			#elif [[ $line == *"paused"* ]]; then
				#**code**
			fi
		elif [[ $line == *" {'Track':"* ]]; then
			updateTrackInfo
			echoTrackInfo
			notifyTrackInfo
		fi		
	done
}

echoDevices() {
	python3 /home/giorgio/Documents/scripts/blueplayer/getObj.py |
	while read -r line; do
		if [[ $(grep -o "/" <<< "$line" | wc -l) == 4 ]]; then
			echo $line
		fi
		
	done
	
}
#echoDevices
startNotifying
