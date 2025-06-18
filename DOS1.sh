#!/bin/bash
# Script performs DOS vector tests using nmap

V=$1
N=$2

# nmap dos
sudo nmap -vv $1 --script dos* -p - -oX dos.xml
xsltproc dos.xml -o dos1.html

# zip
pass=$(openssl rand -base64 6)
zip --password ${pass} dos.zip dos1.html

# Email Report and Password
echo " DOS Report dos.zip" | mail -s "DOS Vectors Report for "$1" " -A dos.zip $2
echo " Your password for "$1" dos.zip is "${pass}" " | mail -s "Your dos.zip Info" $2
