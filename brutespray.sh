#!/bin/bash
# Hyperion v4 https://github.com/x90skysn3k/brutespray
# target
G=$1

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
zip  brsp.zip brsp.html bsr.zip
