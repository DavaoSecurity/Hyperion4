#!/bin/bash
# Script performs POP mail server tests
S=$1
D=$2
# echo " "
# echo " The script is running and may take a while ............"
# echo " "
# nmap vuln
sudo nmap -vv $1 --script vuln --script vulners -p - -oX usernmap.xml
xsltproc usernmap.xml -o usernmapp3vuln.html
# POP3
sudo nmap -vv -sV -sC -p - --script pop3* $1 -oX usernmap3.xml
xsltproc usernmap3.xml -o usernmapop3.html

# zip
pass=$(openssl rand -base64 6)
zip --password ${pass} mailPOP.zip usernmapp3vuln.html usernmapop3.html

# Email Report and Password
echo " POP Mail Server Report mailPOP.zip" | mail -s "Mail POP Report for "$1" " -A mailPOP.zip $2
echo " Your password for "$1" mailPOP.zip is "${pass}" " | mail -s "Your mailPOP.zip Info" $2
