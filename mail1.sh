#!/bin/bash
# Script  performs SMTP server tests
# INSTALL FIRST https://github.com/cytopia/smtp-user-enum
# pip install smtp-user-enum
T=$1
E=$2

# test VRFY with netcat $ nc $1 25

# nmap vuln
sudo nmap -vv $1 --script vuln --script vulners -p - -oX usernmap.xml
xsltproc usernmap.xml -o usermapsmtpvul.html
# SMTP
sudo nmap -vv -p - --script smtp* $1 -oX usernmap2.xml
xsltproc usernmap2.xml -o usermapsmtp.html
# SMTP user enumeration (RCPT TO and VRFY), internal spoofing, and relay.
smtp-user-enum -v -M VRFY -U commonusers.txt -t $1 > smtp.txt
cat smtp.txt | grep exists smtp1.txt
sed -1 '1i SMTP Mail Server Output\n---------------------------' ismtp1.txt
cd ..

# zip
pass=$(openssl rand -base64 6)
zip --password ${pass} smtp.zip usermapsmtpvul.html usermapsmtp.html ismtp1.txt

# Email Report and Password
echo " SMTP Mail Server smtp.zip" | mail -s "Mail SMTP Report for "$1" " -A smtp.zip $2
echo " Your password for "$1" smtp.zip is "${pass}" " | mail -s "Your smtp.zip Info" $2
