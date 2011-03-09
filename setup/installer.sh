#!/bin/sh


# Download packages such as 'toolkit.tar.gz' and installs them into ~/codes.

# 1. Take tars from ./install/download 
# 2. Extract them into install/packages 
# 3. Finally copy them into ~/codes/aux.scm

# PS: Nondestructive. If a package in ~/codes/ already  exists, nothing is done.

set -e
set -u

install=$HOME/install
dl=$install/downloads
pkgs=$install/packages

codes=$HOME/codes
aux=$codes/aux.scm

mode=

# before, we proceed. Did we even download anything?
if [ ! -d "$dl" ]; then
    echo "the download folder $dl is empty"
    echo "run the downloader.sh first"
    exit 1
else
    # Ok, theres is a download folder, we begin the install process.
    cd $dl
fi


[ -d "$codes" ] || mkdir $codes
[ -d "$aux" ] || mkdir -p $aux

rm -rf $pkgs
mkdir -p $pkgs


if [ -z "$(ls -A $dl)" ] ; then
    echo "Error: download $dl folder is empty"
    exit 1
 else
    for d in "$dl"/*; do
        dn=$(basename $d)
        dnf=$(echo $dn | sed 's/\.tar\.gz//g' )
        if [ ! -d "${aux}/${dnf}" ] ; then
            cd $dl
            tar xfz $dn -C $pkgs/
            cp -R $pkgs/$dnf $aux/$dnf
        else
            echo "Warning: ${aux}/${dnf} already exists. Omitting ..."
        fi
    done
fi
