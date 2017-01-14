#!/usr/bin/env sh

dir=$(dirname $1)
mkdir -p $dir
echo "$2" > $1
chown user $1
chmod 600 $1
exit 0
