#!/bin/bash

for d in ${ZDOTDIR:-$HOME}/.dotfiles/*/ ; do
    echo "Linking contents of '$d*' to '${ZDOTDIR:-$HOME}'"
    cp -as $d.* ~
    cp -as $d* ~
done
ls -al /target
