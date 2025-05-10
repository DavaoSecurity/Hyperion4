#!/bin/bash
# DOS detection script

echo "  "
echo " Confirm you have setup your outgoing mail server as per the instructions during install. "
echo " install.sh will install and setup a SMTP server on this local machine. "
echo " You need to specify your Gmail credentials to allow SMTP traffic. "
echo " "
echo " RUN THIS netstat COMMAND FIRST TO GET ATTACKING IP ADDRESS and look in netst.txt .... "
echo " netstat -ntu|awk '{print $5}'|cut -d: -f1 -s|sort|uniq -c|sort -nk1 -r > netst.txt "
echo " "
read -p " What email do you want the results to be sent to ? " umail
read -p " Look in netst.txt. What IP address would you like blocked? Enter 0.0.0.0 if no IP address known " ipban
echo " "
# Check server load. If number is high, investigate.
grep processor /proc/cpuinfo | wc -l > load.txt
sed -i -e '1iServer Load\' load.txt
sed -i -e '2i*************************\' load.txt
# Check network load. See a fairly normal incoming and outgoing network load?
nload > nload.txt
sed -i -e '1iNetwork Load\' nload.txt
sed -i -e '2i*************************\' nload.txt
# What IP addresses connected? IP address with a large number of instances over 100?
netstat -ntu|awk '{print $5}'|cut -d: -f1 -s|sort|uniq -c|sort -nk1 -r > netst.txt
sed -i -e '1iConnected IPs\' netst.txt
sed -i -e '2i*************************\' netst.txt
# process txt files
cat load.txt nload.txt netst.txt | sort > dos.txt
sed -i -e '1iIs a DOS attack happening right now?\' dos.txt
sed -i -e '2i*********************************************************\' dos.txt
# ban attacking IP
route add $ipban reject
route -n |grep $ipban
# kill process using IPTABLES
iptables -A INPUT 1 -s $ipban -j DROP/REJECT
service iptables restart
service iptables save
# Now kill all httpd connections and restart httpd services
killall -KILL httpd
service httpd startssl
# mail
mail -s "Initial and Quick Malware Report" $umail -a dos.txt
echo " Report sent to $umail. "
echo " "
echo " Look at dos.txt carefully and identify the malicious IP address. "
echo " Notify your organisation's Incident Reposnse Team IMMEADIATELY. "
echo " "
