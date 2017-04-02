#!/bin/bash -x

cd `dirname $0`
CURDIR=${PWD}
NAME=`basename $PWD`
docker build --no-cache=true -t $NAME . 
