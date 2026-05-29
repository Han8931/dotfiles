#!/bin/bash
#
# ~/.xinitrc

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

DEFAULT_SESSION='i3 --shmlog-size 0'

if [ -f "$sysresources" ]; then
    xrdb -merge "$sysresources"
fi

if [ -f "$sysmodmap" ]; then
    xmodmap "$sysmodmap"
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

if [ -s "$HOME/.Xmodmap" ]; then
    xmodmap "$HOME/.Xmodmap"
fi

if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

export XDG_CURRENT_DESKTOP=i3

dbus-update-activation-environment --systemd DISPLAY XAUTHORITY XDG_CURRENT_DESKTOP
systemctl --user import-environment DISPLAY XAUTHORITY XDG_CURRENT_DESKTOP

get_session() {
    case "$1" in
        awesome) echo "awesome" ;;
        bspwm) echo "bspwm-session" ;;
        budgie) echo "budgie-desktop" ;;
        cinnamon) echo "cinnamon-session" ;;
        deepin) echo "startdde" ;;
        enlightenment) echo "enlightenment_start" ;;
        fluxbox) echo "startfluxbox" ;;
        gnome) echo "gnome-session" ;;
        i3|i3wm|"") echo "$DEFAULT_SESSION" ;;
        jwm) echo "jwm" ;;
        kde) echo "startplasma-x11" ;;
        lxde) echo "startlxde" ;;
        lxqt) echo "lxqt-session" ;;
        mate) echo "mate-session" ;;
        xfce) echo "xfce4-session" ;;
        openbox) echo "openbox-session" ;;
        *) echo "$DEFAULT_SESSION" ;;
    esac
}

exec $(get_session "$1")
