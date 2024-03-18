#!/bin/bash

options=" Theme \n Waybar \n Ags \n rofi "
selected=$(echo -e "$options" | rofi -dmenu -i -p "Select Option")

case $selected in
" Theme ")
	$HOME/scripts/pick_theme.sh
	;;
" Waybar ")
	cd $HOME/.config/waybar
	$HOME/.config/waybar/pick_variant.sh
	;;
" Ags ")
	notify-send "WIP"
	;;
" rofi ")
	rofi -show drun
	;;
esac
