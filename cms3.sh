#!/bin/bash
# Performs Drupal tests https://github.com/SamJoan/droopescan

Y=$1
Q=$2

# WAF
wafw00f $1 > w.txt
cat w.txt | grep WAF > waf.txt
sed -i '1i WafWoof Results\n----------------------' waf.txt
# Drupal  can chnage scan to drupal wordpress silverstripe joomla moodle
cd droopescan
droopescan scan drupal -u https://$1 > dr.txt
cat dr.txt | grep drupal > droop.txt
sed -i '1i DroopeScan Results\n-------------------' droop.txt
mv droop1.txt /root
cd ..
# drupwn
cd drupwn
drupwn --mode enum --target https://$1 > enum.txt
cat enum.txt | grep CVE > enum1.txt
sed -i '1i Drupwn Enumeratipon\n------------------------' enum1.txt
mv enum1.txt /root
drupwn --mode exploit --target https://$1 > exp.txt
cat exp.txt | grep CVE > exp1.txt
sed -i '1i Drupwn Exploits\n----------------------' exp1.txt
mv exp1.txt /root
cd ..
# whatweb
whatweb -v -a 4 -l --logxml=what.xml $1
xsltproc what.xml > whatcms3.html
# text file combine
cat waf.txt enum1.txt exp1.txt droop.txt > outputcms3.txt

# zip
pass=$(openssl rand -base64 6)
zip --password ${pass} drupal.zip outputcms3.txt whatcms3.html what.xml

# Email Report and Password
echo " Drupal Report drupal.zip" | mail -s "Drupal CMS Report for "$1" " -A drupal.zip $2
echo " Your password for "$1" drupal.zip is "${pass}" " | mail -s "Your drupal.zip Info" $2
