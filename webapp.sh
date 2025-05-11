#!/bin/bash
# Hyperion v4 Script performs tests on webapp using nmap and SQLMap
# INSTALL FIRST https://sqlmap.org/
git clone --depth 1 https://github.com/sqlmapproject/sqlmap.git sqlmap-dev

Z=$1 # target
L=$3 # logon page to attack

# nmap vuln
sudo nmap -vv $1 --script vuln --script vulners --script http* -p - -oX usernmap.xml
xsltproc usernmap.xml -o usermapWebApp.html
# sqlmap
sqlmap -v -u "https://$1/$3" -a --level=5 --risk=5 > sqli.txt
cat sql1.txt | grep 'ssl\|SSL\|OSVDB\|enabled\|open\|Server\|Running\|OS\|Target\|tcp\|udp\|interesting\|XSS\|Heartbleed\|Shellshock\|EternalBlue\|VULNERABLE\|vulnerable\|login\|admin\|CVE\|SSL\|DIRECTORY\|200\|E' > sql.txt
sed -i '1i SQLi Vulnerability\n --------------------' sqli.txt

# zip
zip sql.zip usermapWebApp.html sqli.txt

# clean up
rm usermapWebApp.html sqli.txt usernmap.xml
