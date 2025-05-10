#!/bin/bash
# This will delete ALL the Root mail on this Postfix server plus user generated temp files
cat /dev/null > /var/spool/mail/root
sudo apt update
sudo apt-get autoremove
sudo apt-get clean
# mv big.txt commonpass.txt commonusers.txt dnsmap.txt passwords.txt users.txt dump
# rm *.csv *.txt *.zip *.html *.xml *.csv dead.letter
# cd dump
# mv big.txt commonpass.txt commonusers.txt dnsmap.txt passwords.txt users.txt /root
# cd ..
pkill screen
killall screen
clear
# echo " "
# echo " Open Screens, User Generated, PII and Temporary files have been removed. "
# echo " "
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
# clear
# echo " "
# echo " ALL Docker containers stopped and deleted. "
# echo " "

set -eu
snap list --all | awk '/disabled/{print $1, $3}' |
    while read snapname revision; do
        snap remove "$snapname" --revision="$revision"
    done

rm -rf ~/.cache/thumbnails/*
