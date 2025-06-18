#!/bin/bash
# Script performs malware scans

H=$1
C=$2

# malware category
sudo nmap -v -sU -sT $1 --script malware -p - -oX file.xml
xsltproc file.xml -o malware.html
# eternalblue WannaCry and Petya ransomware
sudo nmap -sV --script http-malware-host $1 -oX mw.xml
xsltproc mw.xml -o malwarehost.html
sudo nmap -p 445 --script smb-vuln-ms17-010 $1 -oX eb.xml
xsltproc eb.xml -o eternalblue.html

# zip
pass=$(openssl rand -base64 6)
zip --password ${pass} malware1.zip malware.html malwarehost.html eternalblue.html

# Email Report and Password
echo " Malware Report malware1.zip" | mail -s "Malware eg EternalBlue Report for "$1" " -A malware1.zip $2
echo " Your password for "$1" malware1.zip is "${pass}" " | mail -s "Your malware1.zip Info" $2
