#!/bin/bash
# Hyperion v4 check for the DKIM vulnerability CVE 2011-1764
# target
F=$1
nmap --script=smtp-vuln-cve2011-1764 -pT:25,465,587 -oX dkim.xml $1

# file conversion
xsltproc dkim.xml -o dkim.html

# zip
zip  dkim.zip dkim.html

# clean up
rm dkim.html dkim.xml
