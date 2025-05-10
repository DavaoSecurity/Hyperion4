#!/bin/bash
# https://hub.packtpub.com/brute-forcing-http-applications-and-web-applications-using-nmap-tutorial/
R=$1
U=$2

# http
# change port if needed
nmap -p 443 --script http-brute -oX httpbf.xml $1
xsltproc hhtpbf.xml -o HTTPBrute.html

# zip
pass=$(openssl rand -base64 6)
zip --password ${pass} httpBF.zip HTTPBrute.html

# Email Report and Password
echo " HTTP Brute httpBF.zip" | mail -s "HTTP BF Report for "$1" " -A httpBF.zip $2
echo " Your password for "$1" httpBF.zip is "${pass}" " | mail -s "Your httpBF.zip Info" $2

