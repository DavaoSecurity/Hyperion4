#!/bin/bash
P=$1
U=$2

# all ftp
sudo nmap -p 20, 21, 990, 989, --script vulns --script vulners --script ftp* $1 -oX ftp.xml
xsltproc ftp.xml -o ftp.html

# zip
pass=$(openssl rand -base64 6)
zip --password ${pass} ftp.zip ftp.html

# Email Report and Password
echo " FTP Report Ports 20 21 990 989 ftp.zip" | mail -s "FTP Server Report for "$1" " -A ftp.zip $2
echo " Your password for "$1" ftp.zip is "${pass}" " | mail -s "Your ftp.zip Info" $2
