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
        [ -e "$hfp" ] &&  { 
            # hfbn: rc-dot-gnu
            hfbn=$(basename $hfp)
            # fatdir: dot-gnu
            fatdir=$(echo $hfbn | sed "s/^$hf\-//g" )
            # dir: gnu
            dir=$(echo $fatdir | sed "s/^.*-//g" )
            dotdir=$(echo "$hfbn" | perl -wnl -e 's/.*-dot-(\w*)$/$1/g and print $1;')
            homedir=$(echo "$hfbn" | perl -wnl -e 's/.*-home-(\w*)$/$1/g and print $1;')

            # dotdir: rc-dot-ssh -> ~/.ssh
            if [ ! "$dotdir" = '' ] ;then
                if [ -e $HOME/.$dotdir ] ; then
                    mv $HOME/.$dotdir $backup/
                else
                     mkdir -p $HOME/.$dotdir
                fi
                if [ -e $HOME/$hf/$dotdir ] ; then
                    rm -rf $HOME/$hf/$dotdir
                fi
                ln -s $hfp $HOME/.$dotdir
                ln -s $hfp $HOME/$hf/$dotdir
            elif [ ! "$homedir" = '' ] ;then
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
                for d in "$hfp"/*; do
                    dn=$(basename $d)
                    if [ -e $HOME/.$dn ] ; then
                        mv $HOME/.$dn $backup/
                    fi
                    ln -s $d $HOME/.$dn
                done
            fi
        }
    done
done

