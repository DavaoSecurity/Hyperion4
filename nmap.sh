#!/bin/bash
# Hyperion v4 namp scans
sudo nmap --script-update
sudo nmap --script-updatedb
# target
a=$1

# aggressive scan
sudo nmap -vv -sT -sU -A -Pn -p- -oX agg.xml $1

# file conversion
xsltproc agg.xml -o AggressiveScan.html

# zip
zip nmap.zip AggressiveScan.html

# clean up
rm agg.xml AggressiveScan.html
