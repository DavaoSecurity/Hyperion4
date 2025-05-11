#!/bin/bash
# Hyperion v4 Install on Ubuntu 22.04.x; 16 GB RAM; 6 Cores; 400 GB SDD; fail2ban; AV; auditd/systat; Lynis harden; sendmail; SMTP only.
# run in Docker; clean up after.
# Docker install latest stable
sudo docker pull ghcr.io/zaproxy/zaproxy:stable
sudo docker pull softwaresecurityproject/zap-stable
a=$1 # target

# Run Baseline Scan
# sudo docker run -t ghcr.io/zaproxy/zaproxy:stable zap-baseline.py -t $rtarg -r $rname
# baseline scan with param file
# sudo docker run -v $(pwd):/zap/wrk/:rw -t ghcr.io/zaproxy/zaproxy:stable zap-baseline.py \
#    -t $rtarg -g gen.conf -r $rname.html
# root privs workaround for Contabo
docker run -v $(pwd):/zap/wrk/:rw --user root ghcr.io/zaproxy/zaproxy:stable zap-full-scan.py -t $1 -g gen.conf -r zapattack.html

# zip
zip zapattack.zip zapattack.html

# clean up
rm zapattack.html
