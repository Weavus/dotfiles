#!/bin/bash

for d in ${ZDOTDIR:-$HOME}/.dotfiles/*/ ; do
    if ! [[ "$d" == *. ]]; then
      echo "Linking contents of '$d' to '${ZDOTDIR:-$HOME}'"
      echo cp -as $d.* ~
    fi
done
echo ls -al ${ZDOTDIR:-$HOME}
