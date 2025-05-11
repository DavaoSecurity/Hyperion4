#!/bin/bash
# Script for Hyperion v4 that performs Uniscan tests fri LFI RFI and RCE vulnerabilities
# INSTALL FIRST https://sourceforge.net/projects/uniscan/    https://www.hackingloops.com/uniscan/
# target
R=$1


# uniscan
cd Uniscan
perl ./uniscan.pl -u https://$1/ -qweds > uni.txt
sed -i '1i LFI, RFI and RCE Detetcion from Inception\n---------------------------------------' uniscan.txt
mv uniscan.txt /root
cd ..
# zip
zip uniscan.zip uniscan.txt

# clean up 
rm uniscan.zip uniscan.txt
cd ..
