#!/bin/bash -x

cd `dirname $0`
CURDIR=${PWD}
NAME=`basename $PWD`
docker build -t $NAME . 
