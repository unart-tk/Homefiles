#!/bin/sh
set -e
set -u

cwd=`pwd`
backup=$cwd/backup
[ -d $backup ] || mkdir -p $backup

dirs=" vi sh rc bin "
# dotdir: 'my-dot-folder'
dotdir=
# homedir: 'my-home-folder'
homedir=

# dr: sh, dd: ./my/path/sh-mydir, ddnl: sh-mydir, ddn: mydir, dir:~/sh/mydir
for dr in $dirs ; do
    [ -d $HOME/$dr ] || mkdir $HOME/$dr

    for dd in "$cwd"/$dr*; do
        [ -e "$dd" ] &&  { 
            ddnl=$(basename $dd)
            ddn=$(echo $ddnl | sed "s/^$dr\-//g" )
            dir=$HOME/$dr/$ddn
            dot=$(echo "$ddnl" | perl -wnl -e 's/.*-dot-(\w*)$/$1/g and print $1;')
            homedir=$(echo "$ddnl" | perl -wnl -e 's/.*-home-(\w*)$/$1/g and print $1;')
            [ -d $dir ] || mkdir $dir
            for d in "$dd"/*; do
                [ -e "$d" ] &&  { 
                    dn=$(basename $d)
                    if [ ! "$dot" = '' ] ;then
                        [ -e $HOME/.$dot ] && mkdir -p $HOME/.$dot
                        [ -e $HOME/.$dot/$dn ] && {
                            mv  $HOME/.$dot/$dn $backup/; }
                        ln -s $d $HOME/.$dot/$dn
                    elif [ ! "$homedir" = '' ] ;then
                        [ -e $HOME/$homedir ] && {
                            mv  $HOME/$homedir $backup/;}
                        ln -s $dd $HOME/$homedir
                    else
                        # link to: ~/vi, ~/sh, ...
                        [ -e $dir/$dn ] &&{
                            mv $dir/$dn $backup/; }
                        ln -s $d $dir/$dn
                        # link to: ~/.
                        [ -e $HOME/.$dn ] && {
                            mv  $HOME/.$dn $backup/$dn ; }
                        ln -s $d $HOME/.$dn
                    fi
                }
            done
        }
    done
done

