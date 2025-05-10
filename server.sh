#!/bin/bash
# Hyperion v4 Script for performs general server tests
3 target
Q=$1

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
zip server.zip usernmapServer.html os.html services.html os1.html

# clean up
rm usernmapServer.html os.html services.html os1.html usernmap.xml os.xml serv.xml
