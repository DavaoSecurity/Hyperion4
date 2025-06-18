#!/bin/bash
# Ubuntu Snap Trivy

trivy fs --scanners vuln / > trivy.txt
sed -i '1i TRIVY Output\--------------------' trivy.txt

# zip
# pass=$(openssl rand -base64 6)
# zip --password ${pass} trivy.zip trivy.txt
zip trivy.zip trivy.txt
# Email Report and Password
echo " Trivy Report trivy.zip" | mail -s " Trivy Scanner Report for Cerebus " -A trivy.zip ducatinat@protonmail.com
# echo " Your password for "$1" trivy.zip is "${pass}" " | mail -s "Your trivy.zip Info" $2
sleep 5
rm trivy.txt trivy.zip
