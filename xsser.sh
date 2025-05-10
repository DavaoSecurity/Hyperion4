#!/bin/bash
# https://www.kali.org/tools/xsser/
h=$1
v=$2
cd xsser
xxser -all $1 -v -s --Da --xml=xsser.xml
xsltproc xsser.xml xsser.html
mv xsser.xml xsser.html /root
cd ..
# zip
pass=$(openssl rand -base64 6)
zip --password ${pass} xxserr.zip xsser.html xsser.xml
echo " Your password for "$1" xxserr.zip is "${pass}" " | mail -s "Your xxserr.zip Info" $2
# Email Report
echo " xxser XSS " | mail -s "xxserr Report for "$1" " -A xxserr.zip $2
