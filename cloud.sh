#!/bin/bash
# script  performs tests on ALL cloud servers
z=$1
x=$2
# nmap vuln
sudo nmap -vv $1 --script vuln --script vulners --script discovery -p - -oX vuln.xml
xsltproc vuln.xml -o cloudvuln.html

# zip
pass=$(openssl rand -base64 6)
zip --password ${pass} cloudvuln.zip cloudvuln.html 

# Email Report and Password
echo " Cloud Report cloudvuln.zip" | mail -s "Cloud Server Report for "$1" " -A cloudvuln.zip $2
echo " Your password for "$1" cloudvuln.zip is "${pass}" " | mail -s "Your cloudvuln.zip Info" $2

