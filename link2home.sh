#!/bin/sh
set -e
set -u

cwd=`pwd`
backup=$cwd/backup
[ -d $backup ] || mkdir -p $backup

homefolders=" vi sh rc bin "
# subdir: my-dir
subdir=
# dotdir: 'my-dot-dir
dotdir=
# homedir: 'my-home-dir
homedir=

linkhome(){
    p=$1
    dir=$2
}


# hf: sh, dd: ./my/path/sh-mydir, hfbn: sh-mydir, ddn: mydir, dir:~/sh/mydir
for hf in $homefolders ; do
    [ -d $HOME/$hf ] || mkdir $HOME/$hf
    
    # $hfp : /my/path/rc-dot-gnu
    for hfp in "$cwd"/$hf*; do
        [ -e "$hfp" ] || continue 
            # hfbn: rc-dot-gnu
            hfbn=$(basename $hfp)
            # fatdir: dot-gnu
            fatdir=$(echo $hfbn | sed "s/^$hf\-//g" )
            # dir: gnu
            dir=$(echo $fatdir | sed "s/^.*-//g" )
            dotdir=$(echo "$hfbn" | perl -wnl -e 's/.*-dot-(\w*)$/$1/g and print $1;')
            homedir=$(echo "$hfbn" | perl -wnl -e 's/.*-home-(\w*)$/$1/g and print $1;')
            
            # homedir
            if [ ! "$homedir" = '' ] ;then
                if [ -e $HOME/$homedir ] ; then
                    mv $HOME/$homedir $backup/
                else
                     mkdir -p $HOME/$homedir
                fi
                if [ -e $HOME/$hf/$homedir ] ; then
                    rm -rf $HOME/$hf/$homedir
                fi
                ln -s $hfp $HOME/$homedir
                ln -s $hfp $HOME/$hf/$homedir
            else
                for df in "$hfp"/*; do
                    [ -e "$df" ] || continue
                    dfn=$(basename $df)
                # dotdir: rc-dot-ssh -> ~/.ssh
                if [ ! "$dotdir" = '' ] ;then
                    if [ -e $HOME/.$dotdir/$dfn ] ; then
                       mv $HOME/.$dotdir/$dfn  $backup/
                    fi
                    if [ -d $HOME/.$dotdir ] ; then
                        rm -f  $HOME/.$dotdir/$dfn
                        ln -s $df $HOME/.$dotdir/$dfn
                    fi
                else
                    if [ -e $HOME/.$dfn ] ; then
                       mv $HOME/.$dfn  $backup/
                    fi
                       rm -f  $HOME/.$dfn
                       ln -s $df $HOME/.$dfn

                       rm -rf  $HOME/$hf/$fatdir
                       ln -s $hfp $HOME/$hf/$fatdir
                fi
                done
            fi
    done
done

