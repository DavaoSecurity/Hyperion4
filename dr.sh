#!/bin/bash
# Hyperion v4 Script  SSL vulns POODLE and DROWN
# target
t=$1

sudo sudo nmap -sV --script sslv2-drown $1 -oX dr.xml
xsltproc dr.xml -o drown.html
#
sudo nmap -sV --version-light --script ssl-poodle -p 443 $1 -oX po.xml
xsltproc po.xml -o poodle.html

# zip
zip dr.zip drown.html poodle.html

# clean up
rm dr.xml po.xml drown.html poodle.html
