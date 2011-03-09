#!/bin/sh

set -e
set -u


. ./0-setup.sh


# directly link tools

rm -f $HOME/tools
ln -s $toolkit/Tools $HOME/tools


# KIT

kit=$HOME/kit

rm -rf $kit
mkdir $kit


for d in $aux/*kit ; do
    [ -n "$d/*" ] &&
    for dr in $d/*; do
        drn=$(basename $dr)
        ln -s $dr $kit/$drn
    done
done


# fill ~/bin

bin=$HOME/bin
[ -d $bin ] || mkdir $bin

rm -f $bin/utils
rm -f $HOME/utils
ln -s $kit/Utils $bin/utils
ln -s $kit/Utils $HOME/utils

rm -f $bin/scripts
rm -f $HOME/scripts
ln -s $kit/Scripts $bin/scripts
ln -s $kit/Scripts $HOME/scripts

rm -f $bin/tools
rm -f $HOME/tools
ln -s $kit/Tools $bin/tools
ln -s $kit/Tools $HOME/tools

rm -f $bin/cmds
rm -f $HOME/cmds
ln -s $kit/Cmds $bin/cmds
ln -s $kit/Cmds $HOME/cmds

rm -f $bin/sw
ln -s $kit/Sw $bin/sw



