#!/bin/bash
p=$1
g=$2
docker run kevinbacon/unicornscan:1.0 -o unis.txt
# zip
pass=$(openssl rand -base64 6)
zip --password ${pass} unicornscan.zip unis.txt
echo " Your password for "$1" unicornscan.zip is "${pass}" " | mail -s "Your unicornscan.zip Info" $2
# Email Report
echo " UnicornScan " | mail -s "UnicornScan Report for "$1" " -A unicornscan.zip $2
