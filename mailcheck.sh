#!/bin/bash
# mail setup checker DNS L1
# secure email document https://www.cisco.com/c/en/us/support/docs/security/email-security-appliance/215360-best-practice-for-email-authentication.html
# Usage: ./mailcheck.sh <domain> <selector>
# DKIM Selector eg selector1, or ask the client if they know it

if [ -z "$1" ]
then
    echo "Usage: ./mailcheck.sh <domain> <selector>"
    echo "The selector is optional, but if not provided"
    echo "the DKIM check will be skipped"
    exit 1
fi
echo
echo "Checking for DKIM, SPF, and DMARC on $1 using selector $2"

echo ---------DKIM---------
if [ -z "$2" ]
then
    echo No DKIM Selector Provided. Skipping DKIM Checks
else
    dig $2._domainkey.$1 TXT +noall +answer | grep -v "^;" > dkim.txt
    sed -i '1i DKIM Reults\n------------------------------------------' dkim.txt
fi

echo ---------SPF---------
dig $1 TXT +noall +answer | grep -v "^;" | grep "v=spf1" > spf1.txt
sed -i '1i SPF1 Results\n---------------------------------------------' spf1.txt
echo ---------DMARC---------
dig _dmarc.$1 TXT +noall +answer | grep -v "^;" > dmarc1.txt
sed -i '1i Dmarc Results\n--------------------------------------------' dmarc1.txt
echo

cat dkim.txt spf1.txt dmarc1.txt > allmail.txt

# zip
zip allmail.zip allmail.txt

# Email Report and Password
# CHANGE THE EMAIL HERE !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
echo " AllMail DKIM SPF DMARC Report" | mail -s "Mail Report for "$1" " -A allmail.zip rav@inception.bz
sleep 5
rm allmail.zip allmail.txt dkim.txt spf1.txt dmarc1.txt




