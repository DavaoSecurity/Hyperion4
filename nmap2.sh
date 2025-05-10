#!/bin/bash
Hyperion v4 nmap scanning
sudo nmap --script-update
sudo nmap --script-updatedb
# target
a=$1

# aggressive scan
# sudo nmap -vv -A -p- -oX agg.xml $rtarg

# detect firewall settings
sudo nmap -vv -sA -p- -Pn -oX firew.xml $1

# http scan
# sudo nmap -vv --script http* -p- -oX http.xml $rtarg

# firewalk scan
sudo nmap -vv --script firewalk -p- -Pn -oX firewalk.xml $1

# basic vulnerability scan
# sudo nmap -vv -p- --script vuln -oX vuln.xml $rtarg

# all ports UDP and TCP
# sudo nmap -sU -sT -p0-65535 -oX allports.xml $rtarg

# file conversion
# xsltproc agg.xml -o AggressiveScan.html
xsltproc firew.xml -o Firewall.html
# xsltproc http.xml -o HTTP.html
# xsltproc vuln.xml -o Vulns.html
# xsltproc allports.xml -o AllPortsUDPTCP.html
xsltproc firewalk.xml -o FireWalk.html

# zip
zip firewall.zip Firewall.html FireWalk.html
# Add Firewall.html or ALLPortsUDPTCP.html as required

# clean up
rm firew.xml Firewall.html firewalk.xml FireWalk.html
