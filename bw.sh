#!/bin/bash
# Script for Hyperion v4 for OWASP BlackWidow webapp scanner
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
zip  bw.zip bw.txt

# clean up
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
