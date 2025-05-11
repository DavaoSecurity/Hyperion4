#!/bin/bash
# Hyperion v4 update script with malware scan
sudo apt update && sudo apt upgrade -y && sudo apt dist-upgrade -y
sudo apt autoclean && sudo apt autoremove -y
rkhunter --propupd
rkhunter --update
cat /var/log/rkhunter.log | grep Warning > rkhunter.txt
rkhunter --check --sk > rkhunter1.txt

# check for rootkits and malware
sudo chkrootkit > malw1.txt
cat malw1.txt | grep "infected" > malw.txt
fail2ban-client status sshd > fail.txt
sar -u > sar.txt
aureport > aur.txt
lynis audit system > lyn.txt
debsums -c > chksum.txt
cat /var/log/lynis.log > lyn2.txt
./serv.sh > serv.txt
cat lyn.txt | grep "Hardening index" > lyn1.txt
ufw status > ufw.txt
zip servermalware.zip serv.txt malw.txt lyn1.txt ufw.txt sar.txt rkhunter1.txt aur.txt fail.txt rkhunter.txt serv.txt
echo "upd.sh Cerebus Report" | mail -s "Update, Cerebus status, Malware and Rootkits" -A servermalware.zip ducatinat@protonmail.com
sleep 5
rm ufw.txt rkhunter1.txt serv.txt rkhunter.txt nslookupmx.txt malw1.txt malwl.txt lyn.txt malw.txt lyn1.txt sar.txt aur.txt lyn2.txt chksum.txt fail.txt serv.txt VPSc1.txt
rm servermalware.zip
# rm *.xml
# rm *.html
# rm dead.letter
# history -c
# history -w
# sudo journalctl --rotate
# sudo journalctl --vacuum-time=8days
# sudo journalctl --vacuum-size=50M
# sudo journalctl --vacuum-files=3
cat /dev/null > /var/spool/mail/root
