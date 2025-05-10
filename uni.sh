#!/bin/bash
# Script for Hyperion v3.x that performs Uniscan tests fri LFI RFI and RCE vulnerabilities
# INSTALL FIRST https://sourceforge.net/projects/uniscan/    https://www.hackingloops.com/uniscan/

R=$1
F=$2

# uniscan
cd Uniscan
perl ./uniscan.pl -u https://$1/ -qweds > uni.txt
sed -i '1i LFI, RFI and RCE Detetcion from Inception\n---------------------------------------' uniscan.txt
mv uniscan.txt /root
cd ..
# zip
pass=$(openssl rand -base64 6)
zip --password ${pass} uniscan.zip uniscan.txt

# Email Report and Password
echo " Uniscan Report uniscan.zip" | mail -s "LFI RFI Uniscan Report for "$1" " -A uniscan.zip $2
echo " Your password for "$1" uniscan.zip is "${pass}" " | mail -s "Your uniscan.zip Info" $2
rm uniscan.zip uniscan.txt
cd ..
