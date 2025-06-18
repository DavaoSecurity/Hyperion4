#!/bin/bash
# https://intel471.com/attack-surface-documentation
# https://github.com/smicallef/spiderfoot
# can us -m to run specific modules for a more targeted scan
h=$1
v=$2
cd spiderfoot-4.0
python3 ./sf.py -s $1 -o tab > sfoot.txt
mv sfoot.txt /root
cd ..
# zip
pass=$(openssl rand -base64 6)
zip --password ${pass} sf.zip sfoot.txt # sf.html
echo " Your password for "$1" sf.zip is "${pass}" " | mail -s "sf.zip Info" $2
# Email Report
echo " SpiderFoot OSINT " | mail -s "SpiderFoot Report for "$1" " -A zapbase.zip $2
sleep 5
rm sfoot.txt sf.zip

