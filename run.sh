#!/bin/bash

cd `dirname $0`
CURDIR=${PWD}
NAME=`basename $PWD`
mkdir -p $CURDIR/share
docker run -v $CURDIR/share:/mnt/host --name=$NAME -ti $NAME
