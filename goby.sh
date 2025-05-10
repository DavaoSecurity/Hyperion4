#!/bin/bash
# Hyperion v4 gobuster for web directories
target
x=$1

docker pull ghcr.io/oj/gobuster:latest
gobuster dns -d $1 -t 50 -w common-names.txt -o goby.txt

# zip
zip gobuster.zip goby.txt

# clean up
rm goby.txt
pkill screen
killall screen
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
