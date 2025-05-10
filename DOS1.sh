#!/bin/bash
# Hyperion v4 Script performs DOS vector tests using nmap
# target
V=$1

# nmap dos
sudo nmap -vv $1 --script dos* -p - -oX dos.xml
xsltproc dos.xml -o dos1.html

# zip

zip dos.zip dos1.html

# clean up
rm dos1.html
