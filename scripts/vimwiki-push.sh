#!/bin/sh

vimwiki_dir=$1

# Commit any changes
git -C $vimwiki_dir update-index -q --refresh > /dev/null
CHANGED=$(git -C $vimwiki_dir diff-index --name-only HEAD --)

if [ -n "$CHANGED" ]; then
	git -C $vimwiki_dir add . > /dev/null
	git -C $vimwiki_dir commit -m '' --allow-empty-message > /dev/null
fi


# Push
git -C $vimwiki_dir update-index -q --refresh > /dev/null
WAITING_COMMITS=$(git -C $vimwiki_dir log origin/master..master)

if [ -n "$WAITING_COMMITS" ]; then
	git -C $vimwiki_dir push > /dev/null
fi
