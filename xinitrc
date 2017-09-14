xrdb -remove && xrdb -merge ~/.Xresources
setxkbmap -rules evdev -model evdev -layout us -variant altgr-intl -option caps:none
synclient TapButton1=1
synclient TapButton2=3
synclient TapButton3=2
exec awesome
