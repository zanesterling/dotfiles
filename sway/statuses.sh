#!/bin/bash

set -x

systemctl --user status pipewire.socket pipewire
systemctl --user status wireplumber wireplumber-audio
systemctl --user status xdg-desktop-portal xdg-desktop-portal-wlr
