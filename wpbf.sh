#!/bin/bash
# https://hub.packtpub.com/brute-forcing-http-applications-and-web-applications-using-nmap-tutorial/
F=$1
D=$2

# http
# change port if needed
nmap -p 443 --script http-wordpress-brute -oX wpbf.xml $1
xsltproc wpbf.xml -o wpBrute.html

# zip
pass=$(openssl rand -base64 6)
zip --password ${pass} WPBF.zip wpBrute.html

# Email Report and Password
echo " WordPress Brute wpBF.zip" | mail -s "WordPress BF Report for "$1" " -A wpBF.zip $2
echo " Your password for "$1" wpBF.zip is "${pass}" " | mail -s "Your wpBF.zip Info" $2
