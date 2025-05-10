#!/bin/bash
# Hyperion v4 https://static.open-scap.org/openscap-1.3/oscap_user_manual.html

rm com.ubuntu.jammy.usn.oval.xml
rm com.ubuntu.jammy.usn.oval.xml.bz2.1

wget https://security-metadata.canonical.com/oval/com.ubuntu.$(lsb_release -cs).usn.oval.xml.bz2
bunzip2 com.ubuntu.$(lsb_release -cs).usn.oval.xml.bz2

oscap oval eval --report scapreport.html com.ubuntu.$(lsb_release -cs).usn.oval.xml

# zip
zip scap.zip scapreport.html

# clean up
rm scapreport.html scap.zip
