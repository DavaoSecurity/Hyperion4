#!/bin/bash
# Hyperion 4 script  performs tests on ALL cloud servers
# target
z=$1

# nmap vuln
sudo nmap -vv $1 --script vuln --script vulners --script discovery -p - -oX vuln.xml
xsltproc vuln.xml -o cloudvuln.html

# zip
zip cloudvuln.zip cloudvuln.html
rm cloudvulnhtml
