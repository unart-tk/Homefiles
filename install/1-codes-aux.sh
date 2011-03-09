#!/bin/sh

set -e
set -u

. ./0-setup.sh

cur=`pwd`


# codes
# ---
if [  -d "$codes_root" ]; then
    rm -f $codes
    ln -s $codes_root $codes
elif [ ! -e "$codes" ]; then
    echo "Error: there is not $codes_root or $codes folder."
    exit 1
fi

# aux
# ---

if [ ! -d "$aux_root" ] ; then
    echo "Error: No aux dir in  $aux_root"
    exit 1
fi
rm -rf $aux
mkdir $aux

[ -n "$(ls -A -- $aux_root )" ] &&
for x in $aux_root/*; do
	    xn=$( basename $x )
	    xrn=$( echo $xn | sed 's/\..*//g' )
       ln -s $x  $aux/$xrn
       rm -f $HOME/$xrn
       ln -s $x  $HOME/$xrn

done



cd $cur
