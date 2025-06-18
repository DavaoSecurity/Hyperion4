#!/bin/bash
# https://static.open-scap.org/openscap-1.3/oscap_user_manual.html

rm com.ubuntu.jammy.usn.oval.xml
rm com.ubuntu.jammy.usn.oval.xml.bz2.1

wget https://security-metadata.canonical.com/oval/com.ubuntu.$(lsb_release -cs).usn.oval.xml.bz2
bunzip2 com.ubuntu.$(lsb_release -cs).usn.oval.xml.bz2

oscap oval eval --report scapreport.html com.ubuntu.$(lsb_release -cs).usn.oval.xml

# zip
# pass=$(openssl rand -base64 6)
# zip --password ${pass} scap.zip scapreport.html
zip scap.zip scapreport.html

# Email Report and Password
echo " OpenSCAP Report scap.zip" | mail -s " SCAP Report for Cerebus " -A scap.zip ducatinat@protonmail.com
# echo " Your password for "$1" scap.zip is "${pass}" " | mail -s "Your scap.zip Info" $2
sleep 5
rm scapreport.html scap.zip
