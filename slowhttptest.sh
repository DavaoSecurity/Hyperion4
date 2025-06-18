#!/bin/bash
# https://github.com/shekyan/slowhttptest/wiki/InstallationAndUsage
h=$1
v=$2
docker build -t slowhttptest:latest .
docker run slowhttptest:latest ./slowhttptest -c 1000 -H -l 300 -g -o myDOS -i 10 -r 200 -t GET -u https://$1 -x 24 -p 3
# docker run slowhttptest:latest ./slowhttptest -c 1000 -B -l 300 -g -o myDOS -i 110 -r 200 -s 8192 -t FAKEVERB -u https://$1 -x 10 -p 3
# docker run slowhttptest:latest ./slowhttptest -c 1000 -H -l 300 -g -o myDOS -i 10 -r 200 -t GET -u https://$1 -x 24 -p 3   # SlowLoris
# docker run slowhttptest:latest ./slowhttptest -c 1000 -X -r 1000 -w 10 -y 20 -n 5 -z 32 -u http://$1 -p 5 -l 350 -e x.x.x.x:8080
# zip
pass=$(openssl rand -base64 6)
zip --password ${pass} slowhttptest.zip myDOS*.html myDOS*.csv
echo " Your password for "$1" slowhttptest.zip is "${pass}" " | mail -s "Your zapbase.zip Info" $2
# Email Report
echo " HTTP DOS Baseline " | mail -s "OWASP ZAP Base Report for "$1" " -A zapbase.zip $2
