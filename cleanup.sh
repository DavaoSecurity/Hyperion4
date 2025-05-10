#!/bin/bash
# This will delete ALL the Root mail on this Postfix server plus user generated temp files
# and clean up Docker and updates
cat /dev/null > /var/spool/mail/root
sudo apt update
sudo apt-get autoremove
sudo apt-get clean
pkill screen
killall screen
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
#
set -eu
snap list --all | awk '/disabled/{print $1, $3}' |
    while read snapname revision; do
        snap remove "$snapname" --revision="$revision"
    done
rm -rf ~/.cache/thumbnails/*
