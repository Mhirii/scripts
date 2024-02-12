#!/bin/bash

themes=$(echo -e " Tokyonight \n Rosepine \n Nero ")
selected_theme=$(echo -e "$themes" | rofi -dmenu -i -config ~/.config/rofi/config.rasi)
fish=~/.config/fish/current_theme.fish
wezterm=~/.config/wezterm/ui.lua
chezmoi=~/.config/chezmoi/chezmoi.toml

alacritty_theme() {
	theme_name="$1"
	theme_path="${HOME}/.config/alacritty/themes/${theme_name}.toml"
	current_theme_path="${HOME}/.config/alacritty/current_theme.toml"

	if [[ -f "$theme_path" ]]; then             # Check if the theme file exists
		ln -sf "$theme_path" "$current_theme_path" # Create the symbolic link
		echo "Alacritty theme set to $theme_name." # Success message
	else
		echo "Theme file $theme_path not found." # Error message if the theme file doesn't exist
	fi
}

rofi_theme() {
	theme_path=${HOME}/.config/rofi/themes/${1}.rasi
	ln -sf $theme_path $HOME/.config/rofi/theme.rasi
}

mako_theme() {
	theme_path=${HOME}/.config/mako/${1}
	ln -sf $theme_path $HOME/.config/mako/config
}

set_theme() {
	alacritty_theme $1
	rofi_theme $1
	mako_theme $1
	case $1 in
	"tokyonight")
		ags -r "(await import('file://$HOME/.config/ags/js/settings/theme.js')).setTheme('Tokyo')"
		sed -i 's/set -x theme .*$/set -x theme tokyonight/' $fish
		sed -i 's/M.color_scheme = "\(.*\)"/M.color_scheme = "tokyonight"/' $wezterm
		sed -i 's/theme = "\(.*\)"/theme = "tokyonight"/' $chezmoi
		;;
	"rosepine")
		ags -r "(await import('file://$HOME/.config/ags/js/settings/theme.js')).setTheme('RosePine')"
		sed -i 's/set -x theme .*$/set -x theme rosepine/' $fish
		sed -i 's/M.color_scheme = "\(.*\)"/M.color_scheme = "rosepine"/' $wezterm
		sed -i 's/theme = "\(.*\)"/theme = "rosepine"/' $chezmoi
		;;
	"nero")
		ags -r "(await import('file://$HOME/.config/ags/js/settings/theme.js')).setTheme('nero')"
		sed -i 's/set -x theme .*$/set -x theme nero/' $fish
		sed -i 's/M.color_scheme = "\(.*\)"/M.color_scheme = "nero"/' $wezterm
		sed -i 's/theme = "\(.*\)"/theme = "nero"/' $chezmoi
		;;
	esac
}

case $selected_theme in
" Tokyonight ")
	set_theme tokyonight
	notify-send theme tokyo
	;;
" Rosepine ")
	set_theme rosepine
	notify-send theme pine
	;;
" Nero ")
	set_theme nero
	notify-send theme nero
	;;
esac