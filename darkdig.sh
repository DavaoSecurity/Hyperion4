#!/bin/bash
# https://github.com/josh0xA/darkdump
r=$1
h=$2 # the URL, keyword or string you want to search on the deepweb; take out the https:// if a person

cd darkdump
python3 darkdump.py --query https://$1. CAN BE A WESBITE OR NOUN--amount 50 > darkweb.txt
sed -i '1i Dark Web Results\n---------------------------------' darkweb.txt
mv darkweb.txt /root/darkweb.txt
cd ..

# zip
pass=$(openssl rand -base64 6)
zip --password ${pass} dark.zip darkweb.txt

# Email Report and Password
echo " Dark Web dark.zip" | mail -s "Dark Web Report for "$1" " -A dark.zip $2
echo " Your password for "$1" dark.zip is "${pass}" " | mail -s "Your dark.zip Info" $2
sleep 5 
rm darkweb.txt dark.zip
