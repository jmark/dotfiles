# /usr/bin/pulseaudio --start &
#export DE=gnome
#export _JAVA_AWT_WM_NONREPARENTING=1
#wmname LG3D
#echo -n en > '/tmp/keymap.txt' &
#while true;do ~/scripts/status.sh; sleep 10;done &
#exec ${HOME}/builds/bin/dwm/bin/dwm

includes=/etc/X11/xinit/xinitrc.d
if [ -d "$includes" ]
then
    for f in "$includes/"*
    do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi
unset includes

#~/data/projects/Werkzeugkasten/scripts/wallpaperd &
i3
