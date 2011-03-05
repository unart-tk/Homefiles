#!/bin/sh
set -e
set -u

cwd=`pwd`
dotfiles=$cwd/sh-dotfiles
shellfiles=$cwd/sh-shellfiles

[  "$#" = 1 ] && { dotfiles="$1" ; }


[ ! -d "$dotfiles" ] && { echo "Error: $dotfiles doesn't exist " && exit 1 ; }

backup=$cwd/backup
[ ! -d "$backup" ] && { mkdir -p $backup ; }


[ -n "$dotfiles" ] &&
for dir in "$dotfiles"/*files; do
  [ -d "$dir" ] && {
    for f in "$dir"/*; do
            fn=$(basename $f)
            [ -e $HOME/.$fn ] && mv $HOME/.$fn $backup/$fn
            ln -s $f $HOME/.$fn
    done
}
done

[ -n "$shellfiles" ] &&
for f in "$shellfiles"/*; do
    fn=$(basename $f)
    mv $HOME/.$fn $backup/$fn
    ln -s $f $HOME/.$fn
done

rm -f $HOME/.aliases
ln -s $cwd/sh-aliases $HOME/.aliases

rm -f $HOME/sbin
ln -s $cwd/sbin $HOME/sbin
