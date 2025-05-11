#!/bin/bash
# Hyperion v4 https://hub.packtpub.com/brute-forcing-http-applications-and-web-applications-using-nmap-tutorial/
F=$1 # target

# http
# change port if needed
nmap -p 443 --script http-wordpress-brute -oX wpbf.xml $1
xsltproc wpbf.xml -o wpBrute.html

# zip
zip WPBF.zip wpBrute.html

# clean up
rm wpbf.xml wpBrute.html
