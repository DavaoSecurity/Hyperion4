#!/bin/bash
# Script performs tests on webapp using nmap and SQLMap
# INSTALL FIRST https://sqlmap.org/
git clone --depth 1 https://github.com/sqlmapproject/sqlmap.git sqlmap-dev

Z=$1
S=$2
L=$3 # logon page to attack

# nmap vuln
sudo nmap -vv $1 --script vuln --script vulners --script http* -p - -oX usernmap.xml
xsltproc usernmap.xml -o usermapWebApp.html
# sqlmap
sqlmap -v -u "https://$1/$3" -a --level=5 --risk=5 > sqli.txt
cat sql1.txt | grep 'ssl\|SSL\|OSVDB\|enabled\|open\|Server\|Running\|OS\|Target\|tcp\|udp\|interesting\|XSS\|Heartbleed\|Shellshock\|EternalBlue\|VULNERABLE\|vulnerable\|login\|admin\|CVE\|SSL\|DIRECTORY\|200\|E' > sql.txt
sed -i '1i SQLi Vulnerability\n --------------------' sqli.txt

# zip
pass=$(openssl rand -base64 6)
zip --password ${pass} sql.zip usermapWebApp.html sqli.txt

# Email Report and Password
echo " SQL Report sq.zip" | mail -s "SQL Injection Report for "$1" " -A sql.zip $2
echo " Your password for "$1" sql.zip is "${pass}" " | mail -s "Your sql.zip Info" $2
