#!/bin/bash
# SICAT exploit finder https://github.com/justakazh/sicat

cd sicat
# --packetstorm --msfmodule --exploitalert --nvd
nmap --open -sV $1 -oX nmap_out.xml
python3 sicat.py -nm nmap_out.xml --exploitdb -o TEST

cd TEST
zip sicatA.zip *.*
mv sicatA.zip /root
cd /
rm -r TEST
rm *.xml
cd ..

# zip
# pass=$(openssl rand -base64 6)
# zip --password ${pass} sicat.zip sicatA.zip
zip sicat.zip sicatA.zip
# Email Report and Password
echo " SICAT Exploit Search sicat.zip" | mail -s " SICAT from NMAP Report for Cerebus " -A sicat.zip ducatinat@protonmail.com
# echo " Your password for "$1" sicat.zip is "${pass}" " | mail -s " Your sicat.zip Info " $2
sleep 5
rm zip sicat.zip sicatA.zip
