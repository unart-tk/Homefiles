#!/bin/sh

set -u
set -e

# This installs a minimal home environment.
# The idea is to feel at home as quick as possible

kit=$HOME/kit

if [ ! -d "$kit" ]; then
    echo "Error: main directory $kit doesn't exist"
    exit 1
fi


#  ### dotfiles

shellfiles="$kit/Dotfiles/bashfiles"
shellextfiles="$kit/Dotfiles/extfiles"
vimdotfiles="$kit/Vimfiles/dotfiles"


for d in $shellfiles/*; do
    [ "$(basename $d)" = '*' ] && echo "Error: no files: $shellfiles" && exit 1
    dn=$(basename "$d")
    rm -f "$HOME/.$dn"
    ln -s "$d" "$HOME/.$dn"
done

for d in $vimdotfiles/*; do
    [ "$(basename $d)" = '*' ] && echo "Error: no files: $vimdotfiles" && exit 1
    dn=$(basename "$d")
    rm -f "$HOME/.$dn"
    ln -s "$d" "$HOME/.$dn"
done


for d in "$shellextfiles"/* ; do
    [ "$(basename $d)" = '*' ] && echo "Error: no files: $shellextfiles" && exit 1
    
    for dx in "$d"/* ; do
            dn=$(basename "$dx")
            rm -f "$HOME/.$dn"
            ln -s "$dx" "$HOME/.$dn"
    done
done



