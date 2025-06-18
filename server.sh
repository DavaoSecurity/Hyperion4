#!/bin/bash
# Script for performs general server tests
Q=$1
W=$2
# nmap vuln
sudo nmap -vv $1 --script vuln --script vulners -p - -oX usernmap.xml
xsltproc usernmap.xml -o usernmapServer.html
# OS detection
sudo nmap -vv -O --osscan-guess --fuzzy $1 -oX os.xml
xsltproc os.xml -o os.html

sudo nmap -vv -p - -A $1 -oX os1.xml
xsltproc os1.xml -o os1.html

# servers, service detection
sudo nmap -vv sV --allports --version-all --version-trace $1 -oX serv.xml
xsltproc serv.xml -o services.html

# zip
pass=$(openssl rand -base64 6)
zip --password ${pass} server.zip usernmapServer.html os.html services.html os1.html

# Email Report and Password
echo " General Server Report server.zip" | mail -s "General Sererv Tests Report for "$1" " -A server.zip $2
echo " Your password for "$1" server.zip is "${pass}" " | mail -s "Your server.zip Info" $2
