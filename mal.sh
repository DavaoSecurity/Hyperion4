#!/bin/bash
# Hyperion v4 Script performs malware scans
# target
H=$1

# malware category
sudo nmap -v -sU -sT $1 --script malware -p - -oX file.xml
xsltproc file.xml -o malware.html
# eternalblue WannaCry and Petya ransomware
sudo nmap -sV --script http-malware-host $1 -oX mw.xml
xsltproc mw.xml -o malwarehost.html
sudo nmap -p 445 --script smb-vuln-ms17-010 $1 -oX eb.xml
xsltproc eb.xml -o eternalblue.html

# zip
zip malware1.zip malware.html malwarehost.html eternalblue.html

# clean up
rm malware.html malwarehost.html eternalblue.html file.xml mw.xml eb.xml
