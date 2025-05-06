#!/bin/bash
# Script for Hyperion 32.x that performs POP mail server tests
# Usage ./mail.sh 8.8.8.8 mydir - as single command line argument but can use website instead of IP address eg google.com for 8.8.8.8.
# First argument $1: $usIP user IP
# seond argumnet $2 mydir
# User Input from  command line arguments
userIP="$1" # IP address eg 8.8.8.8
udir="$2" # directory for reports
echo " "
echo " The script is running and may take a while ............"
echo " "
# nmap vuln
sudo nmap -vv $userIP --script vuln --script vulners -p - -oX usernmap.xml
xslproc usernmap.xml -o usernmapp3vuln.html
# POP3
sudo nmap -vv -sV -sC -p - --script=pop3* $userIP -oX usernmap3.xml
xslproc usernmap3.xml -o usernmapop3.html
# local storage ready for upload to client's container
mkdir $udir
mv usernmapp3vuln.html /$udir/usernmapp3vuln.html
mv usernmapop3.html /$udir/usernmapop3.html
echo " Your results are stored in directory $udir "
sleep 10
