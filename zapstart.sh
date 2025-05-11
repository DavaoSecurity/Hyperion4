#!/bin/bash
# Install on Ubuntu 22.04.x; 16 GB RAM; 6 Cores; 400 GB SDD; fail2ban; AV; auditd/systat; Lynis harden; sendmail; SMTP only.
# run in Docker; clean up after.
# Docker install latest stable
h=$1 # target

sudo docker pull ghcr.io/zaproxy/zaproxy:stable
sudo docker pull softwaresecurityproject/zap-stable
docker run -v $(pwd):/zap/wrk/:rw --user root ghcr.io/zaproxy/zaproxy:stable zap-baseline.py -t $1 -g gen.conf -r zapbase.html

# zip
zip zapbase.zip zapbase.html

# Email Report
rm zapbase.html
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
echo " ALL Docker containers stopped and deleted "

# docker run -v $(pwd):/zap/wrk/:rw --user root ghcr.io/zaproxy/zaproxy:stable zap-baseline.py -t https://imaginet.com.py -g gen.conf -r testreport.html
