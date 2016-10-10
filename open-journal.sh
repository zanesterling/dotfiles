#!/bin/bash
# Cron script for 30-min activity journal

if [ -f /Users/zane/config/checked-in ]; then
	mvim -c "call vimwiki#diary#make_note(v:count1)" + -c 'r !date "+\%n= \%H:\%M =\%n"'
fi
