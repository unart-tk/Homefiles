#!/bin/sh
set -e
set -u

cwd=`pwd`


dirs=" vi sh bin rc "

for dr in $dirs ; do
    [ -d $HOME/$dr ] || mkdir $HOME/$dr

    for d in "$cwd"/$dr*; do
        [  "$d" = "$cwd/$dr*" ] || {
            dnl=$(basename $d)
# superbad !
            dn=$(echo $dnl | xargs perl -e '$i=$ARGV[0]; $i =~ s/^vi\-//g ; print $i;')
            dn=$(echo $dn | xargs perl -e '$i=$ARGV[0]; $i =~ s/^sh\-//g ; print $i;')
            dn=$(echo $dn | xargs perl -e '$i=$ARGV[0]; $i =~ s/^bin\-//g ; print $i;')
            dn=$(echo $dn | xargs perl -e '$i=$ARGV[0]; $i =~ s/^rc\-//g ; print $i;')
            rm -rf $HOME/$dr/$dn
            ln -s $d $HOME/$dr/$dn
        }
    done
done

