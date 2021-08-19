[[ -f ~/.config/X11/xresources ]] && xrdb -merge -I$HOME ~/.config/X11/xresources
sxhkd &
exec bspwm
