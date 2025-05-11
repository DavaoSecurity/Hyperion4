#!/bin/bash
# Hyperion v4 nmap vulnerability scanner using vuln, vulners and vulnscan https://geekflare.com/nmap-vulnerability-scan/
# update vulnerability and nmap databases
sudo nmap --script-update
cd /usr/share/nmap/scripts/
cd vulscan/utilities/updater/
./updateFiles.sh
cd /
clear
# target
b=$1
# run vuln scans TAKES A LONG TIME
sudo nmap --script vuln -vv -Pn -p- -oX vulnv.xml $1
sudo nmap --script vulners -Pn -vv -p- -oX vulners1.xml $1
sudo nmap --script vulscan -Pn -vv -p- -oX vulnscan1.xml $1

# xml to html
xsltproc vulnv.xml -o vuln.html
xsltproc vulners1.xml -o vulners.html
xsltproc vulnscan1.xml -o vulnscan.html

# zip
zip vuln.zip vuln.html vulners.html vulnscan.html

# clean up
rm vulners1.xml vulnscan1.xml vulnv.xml vuln.html vulners.html vulnscan.html
