#!/bin/bash
# Hyperion v4 WAF and Firewall tests
# target
p=$1
# WAF detect/fingerprint
sudo nmap -p 80, 443 --script http-waf-detect --script http-waf-fingerprint $1 -oX waffy.xml
xsltproc waffy.xml -o waffy.html
# WAFWoof web app firewall confirmation
wafw00f $1 > waf1.txt
cat waf1.txt | grep WAF > waf2.txt
sed -i '1i Web application Firewall Detection\n-------------------------------------' waf2.txt
# test firewall rules
sudo nmap -sS -Pn -p- -T4 -vv --reason -oX fwrules.xml $1
xsltproc fwrules.xml -o fwrules.html

# zip

zip firewallA.zip waffy.html fwrules.html waf2.txt

# clean up
rm waffy.xml waffy.html fwrules.xml fwrules.html waf2.txt waf1.txt
