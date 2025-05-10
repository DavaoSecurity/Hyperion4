#!/bin/bash
# Script  SSL vulns POODLE and DROWN

t=$1
s=$2

sudo sudo nmap -sV --script sslv2-drown $1 -oX dr.xml
xsltproc dr.xml -o drown.html
#
sudo nmap -sV --version-light --script ssl-poodle -p 443 $1 -oX po.xml
xsltproc po.xml -o poodle.html

# zip
pass=$(openssl rand -base64 6)
zip --password ${pass} dr.zip drown.html poodle.html

# Email Report and Password
echo " SSL DROWN POODLE Report dr.zip" | mail -s "SSL Vulnerabities Report for "$1" " -A dr.zip $2
echo " Your password for "$1" dr.zip is "${pass}" " | mail -s "Your dr.zip Info" $2
