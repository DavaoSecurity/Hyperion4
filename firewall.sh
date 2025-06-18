#!/bin/bash
p=$1
r=$2
# WAF detect/fingerprint
sudo nmap -p 80, 443 --script http-waf-detect --script http-waf-fingerprint $1 -oX waffy.xml
xsltproc waffy.html -o waffy.html
# WAFWoof web app firewall confirmation
wafw00f $1 > waf1.txt
cat waf1.txt | grep WAF > waf2.txt
sed -i '1i Web application Firewall Detection\n-------------------------------------' waf2.txt
# test firewall rules
sudo nmap -sS -Pn -p- -T4 -vv --reason -oX fwrules.xml $1
xsltproc fwrules.xml -o fwrules.html

# zip
pass=$(openssl rand -base64 6)
zip --password ${pass} firewallA.zip waffy.html fwrules.html waf2.txt

# Email Report and Password
echo " Firewall and WAF Report firewallA.zip" | mail -s "WAF and Firewall Report for "$1" " -A firewallA.zip $2
echo " Your password for "$1" firewallA.zip is "${pass}" " | mail -s "Your firewallA.zip Info" $2

