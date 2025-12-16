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

## Docker desktop
```shell
# Open Docker Desktop.
$ systemctl --user start docker-desktop

# Close Docker Desktop. (or just use the quit button)
$ systemctl --user stop docker-desktop
```

## Core dumps
reference: https://askubuntu.com/questions/1349047/where-do-i-find-core-dump-files-and-how-do-i-view-and-analyze-the-backtrace-st

### Generate core dumps

```shell
# Check the maximum allowed size for core files.
# 0 means 0! Ie. no core file can be created.
$ ulimit -c

# Set the max core file size to be unlimited.
# This is only for the terminal you're in!
$ ulimit -c unlimited
```

### Where are core dumps?

Different places depending on distro and configuration.

Try:
- `/var/lib/apport/coredump`
- `/var/crash/`
- try inspecting `/var/log/apport.log`
- right in the dir you were in when you ran the command

### Use core dumps
```shell
$ gdb path/to/my/executable path/to/core
# If you don't have the executable:
$ gdb -c path/to/core

# When in the GDB prompt:

# show a backtrace
> bt
> where
> bt full
```

### Force a core dump
Run `sleep 30` to start a long-running process.

Press `Ctrl+\` to force a core dump.
