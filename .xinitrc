#!/bin/sh

export MOZ_USE_XINPUT2=1
export MESA_LOG_FILE=/tmp/mesa.log
xset r rate 660 40
xinput set-prop 'DELL0B24:00 04F3:3147 Touchpad' 'libinput Natural Scrolling Enabled' 1
xinput set-prop 'DELL0B24:00 04F3:3147 Touchpad' 'libinput Tapping Enabled' 1
xinput --set-prop 'DELL0B24:00 04F3:3147 Touchpad' 'libinput Accel Speed' 0.2
# xinput --set-prop 'DELL0B24:00 04F3:3147 Touchpad' 'libinput Accel Custom Scroll Step' 0.9
systemctl --user import-environment DISPLAY
xrdb /home/neon/.Xresources
exec i3 >/dev/null 2>&1
