#!/bin/bash
x=$1
i=$2
docker pull ghcr.io/oj/gobuster:latest
gobuster dns -d $1 -t 50 -w common-names.txt -o goby.txt
# zip
pass=$(openssl rand -base64 6)
zip --password ${pass} gobuster.zip goby.txt
echo " Your password for "$1" gobuster.zip is "${pass}" " | mail -s "Your gobuster.zip Info" $2
# Email Report
echo " gobuster Directories " | mail -s "gobuster Report for "$1" " -A gobuster.zip $2
#echo " Email and Password protected Zip file sent successfully to "$remail" ."
sleep 5
rm goby.txt
