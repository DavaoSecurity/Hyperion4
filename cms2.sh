#!/bin/bash
# Script for Hyperion v3.x that performs Joomla tests
# INSTALL FIRST https://github.com/OWASP/joomscan
# git clone https://github.com/rezasp/joomscan.git
H=$1
I=$2

# WAF
wafw00f https://$1 > w.txt
cat w.txt | grep WAF > waf.txt
sed -i '1i WafWoof Results\n----------------------' waf.txt

# Joomla
cd joomscan
perl joomscan.pl --update
perl joomscan.pl -u https://$1 > j.txt
cat j.txt | grep joomla > joom.txt
sed -i '1i Joomla Scan Results\n---------------------' joom.txt
mv joom.txt /root/joom.txt
cd ..

# whatweb
whatweb -v -a 4 -l --logxml=what.xml https://$1
xsltproc what.xml > whatcms2.html
# text file combine
cat waf.txt joom.txt j.txt > outputcms2.txt

# zip
pass=$(openssl rand -base64 6)
zip --password ${pass} joomla.zip outputcms2.txt whatcms2.html

# Email Report and Password
echo " Joomla Report joomla.zip" | mail -s "Joomla CMS Report for "$1" " -A joomla.zip $2
echo " Your password for "$1" joomla.zip is "${pass}" " | mail -s "Your joomla.zip Info" $2
