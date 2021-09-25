#!/bin/bash
FILE="./checkPath.o"
if [[ ! -f $FILE ]];then
    g++ -o checkPath.o -Wall checkPath.cpp
fi
./checkPath.o $1 $2 $3