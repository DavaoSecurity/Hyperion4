#!/bin/bash
# Hyperion v4 Script performs POP mail server tests
S=$1

# nmap vuln
sudo nmap -vv $1 --script vuln --script vulners -p - -oX usernmap.xml
xsltproc usernmap.xml -o usernmapp3vuln.html
# POP3
sudo nmap -vv -sV -sC -p - --script pop3* $1 -oX usernmap3.xml
xsltproc usernmap3.xml -o usernmapop3.html

# zip
zip mailPOP.zip usernmapp3vuln.html usernmapop3.html

# clean up
rm usernmapp3vuln.html usernmapop3.html usernmap.xml usernmap3.xml
