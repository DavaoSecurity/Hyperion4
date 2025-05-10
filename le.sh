#!/bin/bash
# Hyperion v4 explaoit finder for Linux
# INSTALL FIRST
# wget https://raw.githubusercontent.com/mzet-/linux-exploit-suggester/master/linux-exploit-suggester.sh -O les.sh

s=$1 # linux kernel number e.g 2.6.1 try uname -a

uname -a > kernel.txt
# linux exploit suggester
$ ./linux-exploit-suggester.sh --uname $1 > publicexploits.txt
sed -1 '1i Public Exploits \n----------------------------------' publicexploits.txt
linux-exploit-suggester -k $1 > lexploit.txt
# cat le.txt | grep CVE les.txt
sed -1 '1i Linux Exploit Code Available\n----------------------------------' lexploit.txt

# zip
zip linuxexploits.zip lexploit.txt kernel.txt publicexploits.txt

# clean up
rm lexploit.txt kernel.txt publicexploits.txt
