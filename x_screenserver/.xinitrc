xmodmap ~/.Xmodmap
xset s off
xset -dpms
xset s noblank
xset r rate 200 15
xrandr --output HDMI-0 --mode 3840x2160 --refresh 60
exec i3
