#!/usr/bin/env bash
#   █████╗ ██╗     ██╗███╗   ██╗███████╗    ██████╗ ██╗ ██████╗███████╗
#  ██╔══██╗██║     ██║████╗  ██║██╔════╝    ██╔══██╗██║██╔════╝██╔════╝
#  ███████║██║     ██║██╔██╗ ██║█████╗      ██████╔╝██║██║     █████╗
#  ██╔══██║██║     ██║██║╚██╗██║██╔══╝      ██╔══██╗██║██║     ██╔══╝
#  ██║  ██║███████╗██║██║ ╚████║███████╗    ██║  ██║██║╚██████╗███████╗
#  ╚═╝  ╚═╝╚══════╝╚═╝╚═╝  ╚═══╝╚══════╝    ╚═╝  ╚═╝╚═╝ ╚═════╝╚══════╝
#  Author  :  z0mbi3
#  Url     :  https://github.com/gh0stzk/dotfiles
#  About   :  This file will configure and launch the rice.
#

xrandr --output Virtual1 --mode 1920x1080

# Terminate existing processes if necessary.
. "${HOME}"/.config/bspwm/src/Process.bash

# Current Rice
read -r RICE < "$HOME"/.config/bspwm/.rice

# Vars config for Aline Rice
# Bspwm border		# Fade true|false	# Shadows true|false	# Corner radius		# Shadow color
BORDER_WIDTH="0"	P_FADE="true"		P_SHADOWS="true"		P_CORNER_R="6"		SHADOW_C="#000000"

# (Rose Pine Dawn) colorscheme
bg="#faf4ed"  fg="#575279"

black="#f2e9e1"   red="#b4637a"   green="#286983"   yellow="#ea9d34"
blackb="#9893a5"  redb="#b4637a"  greenb="#286983"  yellowb="#ea9d34"

blue="#56949f"   magenta="#907aa9"   cyan="#d7827e"   white="#575279"
blueb="#56949f"  magentab="#907aa9"  cyanb="#d7827e"  whiteb="#575279"

# Set bspwm configuration
set_bspwm_config() {
		bspc config border_width 0
		bspc config top_padding 8
		bspc config bottom_padding 65
		bspc config normal_border_color "#ca9ee6"
		bspc config active_border_color "#ca9ee6"
		bspc config focused_border_color "#8CAAEE"
		bspc config presel_feedback_color "#E78284"
		bspc config left_padding 6
		bspc config right_padding 6
		bspc config window_gap 6
}
# Terminal colors
set_term_config() {
	cat >"$HOME"/.config/alacritty/rice-colors.toml <<EOF
      # Default colors
[colors.primary]
background = "#141b1e"
foreground = "#dadada"

# Cursor colors
[colors.cursor]
cursor = "#2d3437"
text = "#dadada"

# Normal colors
[colors.normal]
black = "#232a2d"    # color0
red = "#e57474"      # color1
green = "#8ccf7e"    # color2
yellow = "#e5c76b"   # color3
blue = "#67b0e8"     # color4
magenta = "#c47fd5"  # color5
cyan = "#6cbfbf"     # color6
white = "#b3b9b8"    # color7

# Bright colors
[colors.bright]
black = "#2d3437"    # color8
red = "#ef7e7e"      # color9
green = "#96d988"    # color10
yellow = "#f4d67a"   # color11
blue = "#71baf2"     # color12
magenta = "#ce89df"  # color13
cyan = "#67cbe7"     # color14
white = "#bdc3c2"    # color15
EOF
	# Kitty config
	cat >"$HOME"/.config/kitty/current-theme.conf <<EOF
# The basic colors
foreground              ${fg}
background              ${bg}
selection_foreground    ${bg}
selection_background    ${magenta}

# Cursor colors
cursor                  ${magenta}
cursor_text_color       ${bg}

# URL underline color when hovering with mouse
url_color               ${blue}

# Kitty window border colors
active_border_color     ${magenta}
inactive_border_color   ${blue}
bell_border_color       ${yellow}

# Tab bar colors
active_tab_foreground   ${bg}
active_tab_background   ${magenta}
inactive_tab_foreground ${blackb}
inactive_tab_background ${black}
tab_bar_background      ${bg}

# The 16 terminal colors

# black
color0 ${black}
color8 ${blackb}

# red
color1 ${red}
color9 ${redb}

# green
color2  ${green}
color10 ${greenb}

# yellow
color3  ${yellow}
color11 ${yellowb}

# blue
color4  ${blue}
color12 ${blueb}

# magenta
color5  ${magenta}
color13 ${magentab}

# cyan
color6  ${cyan}
color14 ${cyanb}

# white
color7  ${white}
color15 ${whiteb}
EOF

pidof -x kitty && killall -USR1 kitty
}

# Set compositor configuration
set_picom_config() {
	sed -i "$HOME"/.config/bspwm/picom.conf \
		-e "s/normal = .*/normal =  { fade = ${P_FADE}; shadow = ${P_SHADOWS}; }/g" \
		-e "s/dock = .*/dock =  { fade = ${P_FADE}; }/g" \
		-e "s/shadow-color = .*/shadow-color = \"${SHADOW_C}\"/g" \
		-e "s/corner-radius = .*/corner-radius = ${P_CORNER_R}/g" \
		-e "s/\".*:class_g = 'Alacritty'\"/\"100:class_g = 'Alacritty'\"/g" \
		-e "s/\".*:class_g = 'kitty'\"/\"100:class_g = 'kitty'\"/g" \
		-e "s/\".*:class_g = 'FloaTerm'\"/\"100:class_g = 'FloaTerm'\"/g"
}

# Set dunst config
set_dunst_config() {
	sed -i "$HOME"/.config/bspwm/dunstrc \
		-e "s/transparency = .*/transparency = 3/g" \
		-e "s/frame_color = .*/frame_color = \"${bg}\"/g" \
		-e "s/separator_color = .*/separator_color = \"${magenta}\"/g" \
		-e "s/font = .*/font = JetBrainsMono NF Medium 9/g" \
		-e "s/foreground='.*'/foreground='${white}'/g"

	sed -i '/urgency_low/Q' "$HOME"/.config/bspwm/dunstrc
	cat >>"$HOME"/.config/bspwm/dunstrc <<-_EOF_
		[urgency_low]
		timeout = 3
		background = "${bg}"
		foreground = "${green}"

		[urgency_normal]
		timeout = 5
		background = "${bg}"
		foreground = "${blackb}"

		[urgency_critical]
		timeout = 0
		background = "${bg}"
		foreground = "${red}"
	_EOF_
}

# Set eww colors
set_eww_colors() {
	cat >"$HOME"/.config/bspwm/eww/colors.scss <<EOF
\$bg: ${bg};
\$bg-alt: ${black};
\$fg: ${fg};
\$black: ${blackb};
\$red: ${red};
\$green: ${green};
\$yellow: ${yellow};
\$blue: ${blue};
\$magenta: ${magenta};
\$cyan: ${cyan};
\$archicon: #0f94d2;
EOF
}

set_launchers() {
	# Jgmenu
	sed -i "$HOME"/.config/bspwm/jgmenurc \
		-e "s/color_menu_bg = .*/color_menu_bg = ${bg}/" \
		-e "s/color_norm_fg = .*/color_norm_fg = ${fg}/" \
		-e "s/color_sel_bg = .*/color_sel_bg = ${black}/" \
		-e "s/color_sel_fg = .*/color_sel_fg = ${fg}/" \
		-e "s/color_sep_fg = .*/color_sep_fg = ${magenta}/"

	# Rofi launchers
	cat >"$HOME"/.config/bspwm/src/rofi-themes/shared.rasi <<EOF
// Rofi colors for Aline

* {
    font: "JetBrainsMono NF Bold 9";
    background: ${bg};
    background-alt: ${bg}E0;
    foreground: ${fg};
    selected: ${cyan};
    active: ${green};
    urgent: ${yellow};

    img-background: url("~/.config/bspwm/rices/${RICE}/rofi.webp", width);
}
EOF
}

# Launch theme
launch_theme() {

	# Set random wallpaper for actual rice
	feh --no-fehbg --bg-fill "${HOME}"/.config/bspwm/rices/"${RICE}"/walls/wall-08.png

	# Launch dunst notification daemon
	dunst -config "${HOME}"/.config/bspwm/dunstrc &

	# Launch polybar
	for mon in $(polybar --list-monitors | cut -d":" -f1); do
		MONITOR=$mon polybar -q aline-bar -c "${HOME}"/.config/bspwm/rices/"${RICE}"/config.ini &
	done
}

### Apply Configurations

set_bspwm_config
set_picom_config
set_dunst_config
set_eww_colors
set_launchers
launch_theme
