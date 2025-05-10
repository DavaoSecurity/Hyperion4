#!/bin/bash

d=$1
k=$2


docker pull powerexploit/ashok-v1.2
docker container run -it powerexploit/ashok-v1.2  --dns imaginet.com.ph > ashok.txt

sed -i -e '1iAshok files\' ashok.txt
sed -i -e '2i***************************\' ashok.txt
cd ..

# zip
pass=$(openssl rand -base64 6)
zip --password ${pass} ashok.zip askok.txt 

# Email Report and Password
echo " Ashok Scan askok.zip" | mail -s "Ashok OSINT Scan Report for "$1" " -A ashok.zip $2
echo " Your password for "$1" ashok.zip is "${pass}" " | mail -s "Your ashok.zip Info" $2
