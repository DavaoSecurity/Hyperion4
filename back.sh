#!/bin/bash
# Script for Hyperion v3.x that performs shellshock, heatbleed, VNC and CITRIX vuln scans
# Usage ./back.sh 8.8.8.8 mydir - as single command line argument but can use website instead of IP address eg google.com for 8.8.8.8.
# First argument $1: $usIP user IP
# Second Argument $2: $udir directory to store reports
# User Input from  command line arguments
userIP="$1" # IP address eg 8.8.8.8
udir="$2" # directory for reports
echo " "
echo " The script is running and may take a while ............"
echo " "
# shellshock
sudo nmap -vv -sV -p- --script http-shellshock $userIP -oX shell.xml
xsltproc shell.xml -o shellshock.html
# targeted shellshock
sudo nmap -vv -sV -p- --script http-shellshock --script-args uri=/cgi-bin/bin,cmd=ls $userIP -oX shell1.xml
xsltproc shell1.xml -o shellshock1.html
# heartbleed
sudo nmap -vv -p 443 --script ssl-heartbleed $userIP -oX hb.xml
xsltproc hb.xml -o heartbleed.html
# VNC
sudo nmap -vv -sV -sC --script vnc* -p 5900 --script=vnc-title $userIP -oX v.xml
xsltproc v.xml -o vnc.html
# CITRIX
sudo nmap -vv -sU --script citrix* -p - $userIP -oX ctx.xml
xsltproc ctx.xml -o citrix.html
# local storage ready for upload to client's container
mkdir $udir
mv *.html /$udir
echo " Your results are stored in directory $udir "
sleep 10
