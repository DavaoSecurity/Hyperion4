#!/bin/bash
# https://help.ubuntu.com/community/ClamAV
# https://reintech.io/blog/configuring-advanced-intrusion-detection-aide-ubuntu-22
# run manually via screen rather than crontab to save resources


sudo aide --check --config /etc/aide/aide.conf > fim.txt
sleep 5
sudo clamscan -v --max-filesize=3999M --max-scansize=3999M --exclude-dir=/sys/* -i -r / > cmav.txt
cat cmav.txt | grep FOUND > clamav.txt
sleep 2

# zip
zip fim.zip fim.txt cmav.txt clamav.txt

# Email Report and Password
echo " AIDE IDS AV Reports fim.zip. No password required. " | mail -s " Intrusion, File Integrity and ClamAV Reports for Cerebus " -A fim.zip ducatinat@protonmail.com
sleep 5
rm fim.zip fim.txt cmav.txt clamav.txt
