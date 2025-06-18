#!/bin/bash
# Ubuntu Snap CVEScan

cvescan -v -p all > cvescan.txt
sed -i '1i CVEScan Output\--------------------' cvescan.txt

# zip
# pass=$(openssl rand -base64 6)
# zip --password ${pass} cvescan.zip cvescan.txt

# Email Report and Password
echo " CVEScan Report cvescan.zip" | mail -s "CVE Scan for Cerebus" -A cvescan.zip ducatinat@protonmail.com
# echo " Your password for "$1" cvescan.zip is "${pass}" " | mail -s "Your cvescan.zip Info" $2
sleep 5
rm cvescan.txt cvescan.zip
