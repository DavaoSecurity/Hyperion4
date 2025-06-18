#!/bin/bash 
# INSTALL FIRST
# wget https://raw.githubusercontent.com/mzet-/linux-exploit-suggester/master/linux-exploit-suggester.sh -O les.sh

s=$1 # linux kernel number e.g 2.6.1 try uname -a
u=$2 
uname -a > kernel.txt
# linux exploit suggester
$ ./linux-exploit-suggester.sh --uname $1 > publicexploits.txt
sed -1 '1i Public Exploits \n----------------------------------' publicexploits.txt
linux-exploit-suggester -k $1 > lexploit.txt
# cat le.txt | grep CVE les.txt
sed -1 '1i Linux Exploit Code Available\n----------------------------------' lexploit.txt

# zip
pass=$(openssl rand -base64 6)
zip --password ${pass} linuxexploits.zip lexploit.txt kernel.txt publicexploits.txt

# Email Report and Password
echo " Search For Exploits linixexploits.zip" | mail -s "Exploit Report for "$1" " -A linuxexploits.zip $2
echo " Your password for "$1" linuxexploits.zip is "${pass}" " | mail -s "Your linuxexploits.zip Info" $2
echo " Your target kernel for "$1" " | mail -s "Your kernel.txt Info" $2
