#!/bin/bash
# Hyperion 4 # CMS recon and enumeration
# General CMS Audit script using Firewall, HTTP/HTTPS and HTML scans. Good for any type of CMS. Uses many tools
# like WhatWeb, WafW00f. The installed CMS will be automatically detected; nmap vuln vulners  on CMS server
# target
E=$1
#
sudo nmap -vv $1 --script vuln --script vulners –sV --script http-enum --script html-cms -p - -oX usernmap.xml
xsltproc usernmap.xml -o usermapCMSall.html
# WAF
wafw00f $1 > w.txt
cat w.txt | grep WAF > waf.txt
sed -i '1i WafWoof Results\n----------------------' waf.txt
# Wapiti
wapiti --update
wapiti -u https://$1
cd /root/.wapiti/scans/
zip wapiti.zip *.*
mv wapiti.zip /root
rm -r *.*
cd /
cd root
# whatweb
whatweb -v -a 4 -l --logxml=what.xml $1
xsltproc what.xml > whatcms.html
# rapidscan
sudo python2.7 ./rapidscan.py $1
sed -i '1i Rapidscan Output\--------------------' rapid.txt
rm RS-Debug-ScanLog

# text file combine
cat waf.txt rapid.txt > outputcms.txt

# zip
zip CMS.zip usermapCMSall.html waf.txt wapiti.zip whatcms.html outputcms.txt RS-Vulnerability-Report

# clean up
rm RS-Vulnerability-Report
