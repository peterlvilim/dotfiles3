xset s off
xset -dpms
xset s noblank
xrandr --output HDMI-0 --mode 3840x2160 --refresh 60
xmodmap ~/.Xmodmap
exec i3
