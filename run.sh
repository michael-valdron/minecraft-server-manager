#!/bin/sh

if [ -z $2 ];
then
    dir=$(pwd)
else
    dir=$2
fi

make -C $dir SRV=$1 run