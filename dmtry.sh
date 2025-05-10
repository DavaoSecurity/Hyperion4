#!/bin/bash
h=$1
v=$2
#
dmitry $1 -o dim

# zip
pass=$(openssl rand -base64 6)
zip --password ${pass} dmitry.zip dim.txt
echo " Your password for "$1" dmitry.zip is "${pass}" " | mail -s "Your dmitry.zip Info" $2

# Email Report
echo " dmitry OSINT " | mail -s "dmitry OSINT Report for "$1" " -A dmitry.zip $2
#echo " Email and Password protected Zip file sent successfully to "$remail" ."
sleep 5
rm dim.txt
