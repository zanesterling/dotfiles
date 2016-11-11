#!/bin/sh

vimwiki_dir=$1

git -C $vimwiki_dir update-index -q --refresh > /dev/null
CHANGED=$(git -C $vimwiki_dir diff-index --name-only HEAD --)

if [ -n "$CHANGED" ]; then
	git -C $vimwiki_dir add . > /dev/null
	git -C $vimwiki_dir commit -m '' --allow-empty-message > /dev/null
	git -C $vimwiki_dir push > /dev/null
fi
