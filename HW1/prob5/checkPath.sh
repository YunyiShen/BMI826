#!/bin/bash
FILE="./checkPath"
if [[ ! -f $FILE ]];then
    g++ -o checkPath -Wall -I../ checkPath.cpp
fi
./checkPath $1 $2 $3