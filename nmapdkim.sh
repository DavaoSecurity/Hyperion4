#!/bin/bash
# check for the DKIM vulnerability CVE 2011-1764

F=$1
S=$2

nmap --script=smtp-vuln-cve2011-1764 -pT:25,465,587 -oX dkim.xml $1

# file conversion
xsltproc dkim.xml -o dkim.html

# zip
pass=$(openssl rand -base64 6)
zip --password ${pass} dkim.zip dkim.html 

# Email Report and Password
echo " DKIM NMAP Scan dkim.zip" | mail -s "DKIM NMAP Scan Report for "$1" " -A dkim.zip $2
echo " Your password for "$1" dkim.zip is "${pass}" " | mail -s "Your dkim.zip Info" $2
sleep 5
rm dkim.zip dkim.html dkim.xml
