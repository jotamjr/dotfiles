xrdb -remove && xrdb -merge ~/.Xresources
setxkbmap -rules evdev -model evdev -layout us -variant altgr-intl -option caps:none
exec awesome
