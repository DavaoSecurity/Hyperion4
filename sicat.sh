#!/bin/bash
# Hyperion v4 SICAT exploit finder https://github.com/justakazh/sicat
# target
M=$1
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
zip sicat.zip sicatA.zip
# clean up
rm zip sicat.zip sicatA.zip
