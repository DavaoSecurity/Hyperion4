#!/bin/bash
# !!!!    FOR NETWORKS ONLY    !!!!
# https://github.com/OWASP/Nettacker?tab=readme-ov-file   https://github.com/OWASP/Nettacker/wiki/Usage

f=$1 # file target(s) list, separate with ,
j=$2

cd Nettacker
python3 nettacker.py -t 10 -v -i $1 -s -m all -o netres.html
mv netres.html /root

# zip
pass=$(openssl rand -base64 6)
zip --password ${pass} nettacker.zip netres.html

# Email Report and Password
echo " OWASP Nettacker Report nettacker.zip" | mail -s "Nettacker Report for "$1" " -A nettacker.zip $2
echo " Your password for "$1" nettacker.zip is "${pass}" " | mail -s "Your nettacker.zip Info" $2
