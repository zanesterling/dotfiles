## WiFi
By command line:
```shell
# List visible networks
$ nmcli device wifi list

# Connect to a network
$ nmcli device wifi connect "$SSID" password "$PASSWORD"

# Enable wifi if you accidentally hit the wifi-off button.
$ nmcli radio wifi on

# More examples:
$ man nmcli-examples
```

In i3 there should be a widget at bottom-right of the screen.

## Inspecting hardware
```shell
# CPU
$ cat /proc/cpuinfo

# GPU
$ sudo lshw -c display

# USB devices
$ lsusb

# PCI(e) devices
$ lspci

# Memory cards
$ lspcmcia
```

## Configuring Sway
There's a default Sway config in `/etc/sway/config`.

The config used is in `~/.config/sway/config`.

## Check Ubuntu version
```shell
$ lsb_release -a
```

## Docs
```shell
# Search for all man pages containing the string "blah".
$ man -k blah

# Look at info docs.
# What the heck are these?
$ info
```

## Clipboard
### Wayland
You will need to install `clipman` and configure it in the swaycfg.
```shell
$ echo foo | wl-copy
$ wl-paste
foo
```
