#!/bin/bash
# Hyperion v4 FTP server test
# target
P=$1

# all ftp
sudo nmap -p 20, 21, 990, 989, --script vulns --script vulners --script ftp* $1 -oX ftp.xml
xsltproc ftp.xml -o ftp.html

# zip
zip ftp.zip ftp.html

# clean up
rm ftp.xml ftp.html
