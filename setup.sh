#!/bin/bash

read -a DOTFILES <<< $(cat homedir-files)

cp $DOTFILES $HOME
