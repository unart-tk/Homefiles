#!/bin/sh
set -e
set -u

cwd=`pwd`
backup=$cwd/backup
[ -d $backup ] || mkdir -p $backup

dirs=" vi sh rc "
# dr: sh, dd: ./my/path/sh-mydir, ddnl: sh-mydir, ddn: mydir, dir:~/sh/mydir
for dr in $dirs ; do
    [ -d $HOME/$dr ] || mkdir $HOME/$dr

    for dd in "$cwd"/$dr*; do
        [ -e "$dd" ] &&  { 
            ddnl=$(basename $dd)
            ddn=$(echo $ddnl | sed "s/^$dr\-//g" )
            dir=$HOME/$dr/$ddn
            [ -d $dir ] || mkdir $dir
            for d in "$dd"/*; do
                [ -e "$d" ] &&  { 
                    dn=$(basename $d)
                    # link to: ~/vi, ~/sh, ...
                    rm -rf $dir/$dn
                    ln -s $d $dir/$dn
                    # link to: ~/.
                    mv  $HOME/.$dn $backup/$dn
                    ln -s $d $HOME/.$dn
                }
            done
        }
    done
done

# ~/bin

dirs=" bin  "
for dr in $dirs ; do
    [ -d $HOME/$dr ] || mkdir -p $HOME/$dr

    for d in "$cwd"/*$dr; do
        [  "$d" = "$cwd/$dr*" ] || {
            dnl=$(basename $d)
            dn=$(echo $dnl | sed "s/-$dr$//g" )
            mv  $HOME/$dn $backup/$dn
            ln -s $d $HOME/$dn

            rm -rf $HOME/$dr/$dn
            ln -s $d $HOME/$dr/$dn
        }
    done
done

