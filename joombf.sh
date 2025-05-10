#!/bin/bash
# Hyperion v4 joomla bruteforce https://hub.packtpub.com/brute-forcing-http-applications-and-web-applications-using-nmap-tutorial/
# target
L=$1

# http
# change port if needed
nmap -p 443 --script http-joomla-brute -oX joombf.xml $1
xsltproc joombf.xml -o joomBrute.html

# zip
zip joomBF.zip HTTPBrute.html

# clean up
rm HTTPBrute.html joombf.xml
