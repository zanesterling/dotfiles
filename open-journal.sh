#!/bin/bash
# Cron script for 30-min activity journal

export PATH=$PATH:/usr/local/bin
if [ -f /Users/zane/config/checked-in ]; then
	cd ~/vimwiki
	mvim -c "silent call vimwiki#diary#make_note(v:count1)" + -c 'r !date "+\%n= \%H:\%M =\%n"'
fi
