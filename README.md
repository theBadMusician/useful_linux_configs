# Useful scripts, configs, and other goodies for Linux environment

## Enable global tty read/write privileges for all users

Run the following command in the terminal:
```bash
$ sudoedit /etc/udev/rules.d/50-myusb.rules
```

Add the following lines to the file:
```
KERNEL=="ttyUSB[0-9]*",MODE="0666"
KERNEL=="ttyACM[0-9]*",MODE="0666"
KERNEL=="tty[0-99]*",MODE="0666"
KERNEL=="ttyS[0-99]*",MODE="0666"
```
