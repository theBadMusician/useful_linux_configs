## Install dummy xorg screen pkg:
#sudo apt install xserver-xorg-video-dummy

## Setup virtual monitors:
#sudo nano /usr/share/X11/xorg.conf.d/20-intel.conf

#Section "Device"
#    Identifier "intelgpu0"
#    Driver "intel"
#    Option "VirtualHeads" "2"
#EndSection

## In case, black screen or to setup nvidia virt screen:
## nvidia/nouveau/amdgpu device should be configured first before Intel GPU
#Section "Device"
#  Identifier "nvidiagpu0"
#  Driver     "nvidia" # Because you are using Nvidia proprietary driver. Change to "nouveau" if you are using open source nouveau driver
#EndSection

## Then configure intel internal GPU
#Section "Device"
#  Identifier "intelgpu0"
#  Driver     "intel"
#  Option     "VirtualHeads" "2"
#EndSection

# Add new mode to xrandr, can be generated using "cvt" command:
xrandr --newmode "1112x814_60.00"   74.00  1112 1176 1288 1464  814 817 827 845 -hsync +vsync

# Add the new mode to the virtual output:
xrandr --addmode VIRTUAL1 "1112x814_60.00"

# Add the output to the display:
xrandr --output VIRTUAL1 --mode 1112x814_60.00 --right-of eDP1
xrandr --output VIRTUAL1 --mode 1112x814_60.00 --pos 3408x0
