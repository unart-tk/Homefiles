#!/bin/sh

[ -d 'backup' ] || mkdir 'backup'

[ -e $HOME/.aliases ] && mv $HOME/.aliases backup
ln -s `pwd`/aliases $HOME/.aliases

for f in shell/*; do
	fn=$(basename $f)
	[ -e $HOME/$fn  ]  && {
		[ -e $HOME/.$fn ] && mv $HOME/.$fn backup/
		ln -s `pwd`/$f $HOME/.$fn
        }
done

for f in xshell/*; do
	fn=$(basename $f)
	[ -e $HOME/$fn  ]  && {
		[ -e $HOME/.$fn ] && mv $HOME/.$fn backup/
		ln -s `pwd`/$f $HOME/.$fn
        }
done

