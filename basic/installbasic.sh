#!/bin/sh

# (c) 2011 Ben, untar.org

# install a basic system



dirs="`pwd`/bashbasic `pwd`/vimbasic"

for d in $dirs ; do
    if [ -d $d ]; then
        for f in $d/*; do
            fn='xxx'
            fn=$(basename $f)
            mv  $HOME/.$fn $HOME/.${fn}.orig
            ln -s $f $HOME/.$fn
        done
    else
        echo "Error: directory $d doesn't exist"
        exit
    fi
done

