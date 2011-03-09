#!/bin/sh


. ./0-setup.sh

set -e
set -u

repos=$HOME/repos

rm -rf $repos
mkdir $repos

[ ! -d "$works_root" ] && {
    echo "$works_root doesn't exist. Exit."
    exit 1
}


for c in $works_root/*; do
	cn=$(basename $c)
	scn=$(echo $cn | sed 's/\..*//g')
    [ "$(echo $cn | grep '\.scm')" ] && {
        for r in $c/*; do
            rn=$(basename $r)
            srn=$( echo $rn | sed 's/\..*//g' )
            rm -f $repos/$srn
            ln -s $r  $repos/$srn
        done
    }
done




