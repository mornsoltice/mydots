#!/usr/bin/env bash
#  ███████╗███╗   ███╗██╗██╗     ██╗ █████╗     ██████╗ ██╗ ██████╗███████╗
#  ██╔════╝████╗ ████║██║██║     ██║██╔══██╗    ██╔══██╗██║██╔════╝██╔════╝
#  █████╗  ██╔████╔██║██║██║     ██║███████║    ██████╔╝██║██║     █████╗
#  ██╔══╝  ██║╚██╔╝██║██║██║     ██║██╔══██║    ██╔══██╗██║██║     ██╔══╝
#  ███████╗██║ ╚═╝ ██║██║███████╗██║██║  ██║    ██║  ██║██║╚██████╗███████╗
#  ╚══════╝╚═╝     ╚═╝╚═╝╚══════╝╚═╝╚═╝  ╚═╝    ╚═╝  ╚═╝╚═╝ ╚═════╝╚══════╝
#  Author  :  z0mbi3
#  Url     :  https://github.com/gh0stzk/dotfiles
#  About   :  This file will configure and launch the rice.
#

# Terminate existing processes if necessary.
. "${HOME}"/.config/bspwm/src/Process.bash

# Current Rice
read -r RICE < "$HOME"/.config/bspwm/.rice

# Vars config for Emilia Rice
# Bspwm border		# Fade true|false	# Shadows true|false	# Corner radius		# Shadow color
BORDER_WIDTH="12"	P_FADE="true"		P_SHADOWS="true"		P_CORNER_R="6"		SHADOW_C="#000000"


bg = #2f354b
bg-alt = #BF1D1F28
fg = #FDFDFD

trans = #00000000
white = #FFFFFF
black = #000000

red = #F37F97
pink = #EC407A
purple = #C574DD
blue = #8897F4
cyan = #79E6F3
teal = #00B19F
green = #5ADECD
lime = #B9C244
yellow = #F2A272
amber = #FBC02D
orange = #E57C46
brown = #AC8476
grey = #8C8C8C
indigo = #6C77BB
blue-gray = #6D8895


# Set bspwm configuration
set_bspwm_config() {
	bspc config window_gap 12
bspc config border_width 2

bspc config split_ratio 0.5
bspc config borderless_monocle true
bspc config gapless_monocle true

bspc config pointer_modifier mod1
bspc config pointer_action1 move
bspc config pointer_action2 resize_side
bspc config pointer_action3 resize_corner
}

# Terminal colors
set_term_config() {
	cat >"$HOME"/.config/alacritty/rice-colors.toml <<EOF
# Default colors
[colors.primary]
background = "${bg}"
foreground = "${fg}"

# Cursor colors
[colors.cursor]
cursor = "${fg}"
text = "${bg}"

# Normal colors
[colors.normal]
black = "${black}"
red = "${red}"
green = "${green}"
yellow = "${yellow}"
blue = "${blue}"
magenta = "${magenta}"
cyan = "${cyan}"
white = "${white}"

# Bright colors
[colors.bright]
black = "${blackb}"
red = "${redb}"
green = "${greenb}"
yellow = "${yellowb}"
blue = "${blueb}"
magenta = "${magentab}"
cyan = "${cyanb}"
white = "${whiteb}"
EOF

  # Set kitty colorscheme
  cat >"$HOME"/.config/kitty/current-theme.conf <<EOF
# The basic colors
foreground              ${fg}
background              ${bg}
selection_foreground    ${bg}
selection_background    ${magenta}

# Cursor colors
cursor                  ${fg}
cursor_text_color       ${bg}

# URL underline color when hovering with mouse
url_color               ${blue}

# Kitty window border colors
active_border_color     ${magenta}
inactive_border_color   ${blackb}
bell_border_color       ${yellow}

# Tab bar colors
active_tab_foreground   ${bg}
active_tab_background   ${magenta}
inactive_tab_foreground ${white}
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
	sed -i "$HOME"/.config/bspwm/rices/soltice/picom.conf \
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
		-e "s/transparency = .*/transparency = 0/g" \
		-e "s/frame_color = .*/frame_color = \"${bg}\"/g" \
		-e "s/separator_color = .*/separator_color = \"${magenta}\"/g" \
		-e "s/font = .*/font = JetBrainsMono NF Medium 9/g" \
		-e "s/foreground='.*'/foreground='${blue}'/g"

	sed -i '/urgency_low/Q' "$HOME"/.config/bspwm/dunstrc
	cat >>"$HOME"/.config/bspwm/dunstrc <<-_EOF_
		[urgency_low]
		timeout = 3
		background = "${bg}"
		foreground = "${green}"

		[urgency_normal]
		timeout = 5
		background = "${bg}"
		foreground = "${white}"

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
\$bg-alt: #222330;
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
		-e "s/color_sel_bg = .*/color_sel_bg = #222330/" \
		-e "s/color_sel_fg = .*/color_sel_fg = ${fg}/" \
		-e "s/color_sep_fg = .*/color_sep_fg = ${black}/"

	# Rofi launchers
	cat >"$HOME"/.config/bspwm/src/rofi-themes/shared.rasi <<EOF
// Rofi colors for Emilia

* {
    font: "JetBrainsMono NF Bold 9";
    background: ${bg};
    background-alt: ${bg}E0;
    foreground: ${fg};
    selected: ${blue};
    active: ${green};
    urgent: ${red};

    img-background: url("~/.config/bspwm/rices/${RICE}/rofi.webp", width);
}
EOF
}

launch_theme() {

    # Launch dunst notification daemon
    dunst -config "${HOME}"/.config/bspwm/dunstrc &

    # Terminate already running bar instances
    killall -q polybar

    # Wait until the processes have been shut down
    while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

    # Launch Polybar for each configuration
    MONITOR=$mon polybar -q pam1 -c "${HOME}"/.config/polybar/config.ini &
    MONITOR=$mon polybar -q pam2 -c "${HOME}"/.config/polybar/config.ini &
    MONITOR=$mon polybar -q pam3 -c "${HOME}"/.config/polybar/config.ini &
    MONITOR=$mon polybar -q pam4 -c "${HOME}"/.config/polybar/config.ini &
    MONITOR=$mon polybar -q pam5 -c "${HOME}"/.config/polybar/config.ini &
    MONITOR=$mon polybar -q pam6 -c "${HOME}"/.config/polybar/config.ini &
}
### Apply Configurations

set_bspwm_config
set_picom_config
set_dunst_config
set_eww_colors
set_launchers
launch_theme
xrandr --output virtual1 --mode 1920x1080
