#!/bin/bash
# Hyperion v4 https://github.com/josh0xA/darkdump
r=$1 # the URL, keyword or string you want to search on the deepweb; take out the https:// if a person

cd darkdump
python3 darkdump.py --query https://$1. CAN BE A WESBITE OR NOUN--amount 50 > darkweb.txt
sed -i '1i Dark Web Results\n---------------------------------' darkweb.txt
mv darkweb.txt /root/darkweb.txt
cd ..

# zip
zip dark.zip darkweb.txt

# clean up
rm darkweb.txt
