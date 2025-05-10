#!/bin/bash
# Script for Hyperion v3.x for OWASP BlackWidow webapp scanner
# INSTALL FIRST https://github.com/1n3/blackwidow

U=$1
G=$2

# Blackwidow
cd BlackWidow
docker build -t blackwidow .
docker run -it blackwidow -d $1 -l 5 -s y -v y
cd /
cd /usr/share/blackwidow/$1
cat *.txt > bw.txt
sed -i '1i BlackWidow OWASP Top 10 Results\n----------------------------------' bw.txt
# blackwidow -u https://target.com - crawl target.com with 3 levels of depth.
# blackwidow -d target.com -l 5 -v y - crawl the domain: target.com with 5 levels of depth with verbose logging enabled.
# blackwidow -d target.com -l 5 -c 'test=test' - crawl the domain: target.com with 5 levels of depth using the cookie 'test=test'
# blackwidow -d target.com -l 5 -s y -v y - crawl the domain: target.com with 5 levels of depth and fuzz all unique parameters for OWASP vulnerabilities with verbose logging on.
# injectx.py -u https://test.com/uers.php?user=1&admin=true -v y - Fuzz all GET parameters for common OWASP vulnerabilities with verbose logging enabled.
# cd ${userdom}_80
mv /usr/share/blackwidow/bw.txt /root
cd /
cd root
# zip
pass=$(openssl rand -base64 6)
zip --password ${pass} bw.zip bw.txt

# Email Report and Password
echo " OWASP BlackWidow Report bw.zip" | mail -s "OWASP BlackWidow Report for "$1" " -A bw.zip $2
echo " Your password for "$1" bw.zip is "${pass}" " | mail -s "Your bw.zip Info" $2
rm bw.zip bx.txt
cd ..
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
