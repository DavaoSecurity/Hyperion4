#!/bin/bash
# Shellshock HeartBleed VNC Citrix testing for backdoors and malware
s=$1
d=$2

# shellshock
sudo nmap -vv -sV -p- --script http-shellshock $1 -oX shell.xml
xsltproc shell.xml -o shellshock.html
# targeted shellshock
sudo nmap -vv -sV -p- --script http-shellshock --script-args uri=/cgi-bin/bin,cmd=ls $1 -oX shell1.xml
xsltproc shell1.xml -o shellshock1.html
# heartbleed
sudo nmap -vv -p 443 --script ssl-heartbleed $1 -oX hb.xml
xsltproc hb.xml -o heartbleed.html
# VNC
sudo nmap -vv -sV -sC --script vnc* -p 5900 $1 -oX v.xml
xsltproc v.xml -o vnc.html
# CITRIX
sudo nmap -vv -sU --script citrix* -p - $1 -oX ctx.xml
xsltproc ctx.xml -o citrix.html

# zip
pass=$(openssl rand -base64 6)
zip --password ${pass} malware.zip shellshock.html shellshock1.html heartbleed.html vnc.html citrix.html

# Email Report and Password
echo " Malware Report malware.zip" | mail -s "Malware Report for "$1" " -A malware.zip $2
echo " Your password for "$1" malware.zip is "${pass}" " | mail -s "Your malware.zip Info" $2
