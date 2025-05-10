#!/bin/bash
# Install on Ubuntu 22.04.x; 16 GB RAM; 6 Cores; 400 GB SDD; fail2ban; AV; auditd/systat; Lynis harden; sendmail; SMTP only.
# run in Docker; clean up after.
# Docker install latest stable
sudo docker pull ghcr.io/zaproxy/zaproxy:stable
sudo docker pull softwaresecurityproject/zap-stable
sleep 2
docker run -v $(pwd):/zap/wrk/:rw --user root ghcr.io/zaproxy/zaproxy:stable zap-baseline.py -t $1 -g gen.conf -r zapbase.html
sleep 2

# zip
pass=$(openssl rand -base64 6)
zip --password ${pass} zapbase.zip zapbase.html
echo " Your password for "$1" zapbase.zip is "${pass}" " | mail -s "Your zapbase.zip Info" $2

# Email Report
echo " OWASP ZAP Baseline " | mail -s "OWASP ZAP Base Report for "$1" " -A zapbase.zip $2 

# docker run -v $(pwd):/zap/wrk/:rw --user root ghcr.io/zaproxy/zaproxy:stable zap-baseline.py -t https://imaginet.com.py -g gen.conf -r testreport.html
