#!/bin/bash
# Hyperion v4 https://hub.packtpub.com/brute-forcing-http-applications-and-web-applications-using-nmap-tutorial/
R=$1

# http
# change port if needed
nmap -p 443 --script http-brute -oX httpbf.xml $1
xsltproc hhtpbf.xml -o HTTPBrute.html

# zip
zip httpBF.zip HTTPBrute.html

# clean up
rm httpbf.xml HTTPBrute.html
