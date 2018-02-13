#!/bin/bash

for d in ${ZDOTDIR:-$HOME}/.dotfiles/*/ ; do
    echo "Linking $d* to ${ZDOTDIR:-$HOME}"
    ln -s "$d/*" "${ZDOTDIR:-$HOME}"
done
