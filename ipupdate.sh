#!/bin/bash
# Hyperion v4 IP banned list update
curl -o firewall.gz 'https://dl.ip2location.com/v1/firewall?token=uCibMSgoKRlnVDyaPu7WQZt7EWEg9r4InvisDlEaVfppftD1imELJQo5Anxl6n0i&country=RU|CN&format=cidr'
gzip -d firewall.gz
cat firewall > firewall.txt
while read line; do sudo ufw deny from $line; done < firewall.txt
