#!/bin/bash
# Hyperion v4 Script performs SMTP server tests
# INSTALL FIRST https://github.com/cytopia/smtp-user-enum
# pip install smtp-user-enum
# target
T=$1
# test VRFY with netcat $ nc $1 25

# nmap vuln
sudo nmap -vv $1 --script vuln --script vulners -p - -oX
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
zip smtp.zip usermapsmtpvul.html usermapsmtp.html ismtp1.txt

# clean up
rm usermapsmtpvul.html usermapsmtp.html smtp.txt ismtp1.txt usernmap.xml usernmap2.xml
