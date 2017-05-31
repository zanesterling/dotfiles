#!/bin/bash

read -a DOTFILES <<< $(cat homedir-files)

cp -R ${DOTFILES[@]} $HOME
