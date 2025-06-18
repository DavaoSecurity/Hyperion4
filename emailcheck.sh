#!/bin/bash
# Email records check 

t=$1
n=$2

#
dig TXT $1 > spf1.txt
sed -i '1i SPF Email Settings Results\n----------------------------' spf1.txt
dig TXT dkim._domainkey.$1 > dkim1.txt
sed -i '1i DKIM Email Settings Results\n----------------------------' dkim1.txt
dig TXT _dmarc. $1 > dmar1.txt
sed -i '1i DMARC Email Settings Results\n----------------------------' dmar1.txt

# zip
zip emailcheck.zip spf1.txt dkim1.txt dmar1.txt

# Email Report and Password
echo " EmailCheck " | mail -s "DKIM SPF DMARC Check " -A emailcheck.zip $2
sleep 5
rm emailcheck.zip spf1.txt dkim1.txt dmar1.txt
