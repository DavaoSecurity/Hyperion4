#!/bin/bash
# Hyperion 4 nmap scans
sudo nmap --script-update
sudo nmap --script-updatedb
# target
a=$1

# http scan
nmap -vv -p- -Pn --script http* -oX web.xml $1

# file conversion
xsltproc web.xml -o web.html

# zip
zip nmap1.zip web.html

# clean up
rm web.xml web.html
