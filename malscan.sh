#!/bin/bash
# Hyperion v4 script to check linux system for Malware. This script is only the malware scan. Installation is already assumed.
H=$1
P=$3 # PID from netstat

# investigation        netstat -nalp  # for unusual processes and open ports

ls -al /proc/$3 > procPID.txt
cp /proc/$3/exe /tmp/recovered_bin > delbin.txt  # to recover any deleted binary
strings /proc/$3/environ > proc.txt              # explore process environment
cat /proc/$3/stack > stackmal.txt                # investigate Linux malware stack
ls -al /proc/$3/fd > filedes.txt                 # show malware open file descriptors
cat /proc/$3/maps > procmaps.txt                 # investigate malware process maps
cat /proc/$3/status pidstats.txt                 # get the PID status
cat procPID.txt delbin.txt proc.txt stackmal.txt filedes.txt procmaps.txt pidstats.txt > ProccesID.txt

# lynis
lynis audit system | grep malware > lynis.txt
sed -i -e '1iLynis Report\' lynis.txt
sed -i -e '2i***************************************\' lynis.txt
# Check rootkit
sudo chkrootkit | grep "infected" > rootkit.txt
sed -i -e '1iChkrootkit Report\' rootkit.txt
sed -i -e '2i***************************************\' rootkit.txt
# rkhunter
rkhunter -c | grep "infected" > rkhunt.txt
sed -i -e '1iRkhunter Report\' rkhunt.txt
sed -i -e '2i***************************************\' rkhunt.txt
# clamav
freshclam
clamscan -r -i C: | grep "infected" > clamav.txt
sed -i -e '1iClamAV Report\' clamav.txt
sed -i -e '2i***************************************\' clamav.txt
# Linux Malware Detect LMD https://www.tecmint.com/install-linux-malware-detect-lmd-in-rhel-centos-and-fedora/
# edit /usr/local/maldetect/conf.maldet to include your email and scan options
maldet --scan-all /var/www/ > lmd.txt
sed -i -e '1iLinux Malware Detector Report\' lmd.txt
sed -i -e '2i***************************************\' lmd.txt
# maldet --scan-all /var/www/*.zip
# maldet --report 021015-1051.3559
rm -rf /usr/local/maldetect/quarantine/* # remove quarantined files
# maldet --clean SCANID
# set crontab -e
#
# process txt files
cat ProccesID.txt lynis.txt clamav.txt rootkit.txt rkhunt.txt lmd.txt | sort > malrep.txt
sed -i -e '1iCOMBINED MALWARE REPORT Lynis chkrootkit rkhunter ClamAV LMD\' malrep.txt
sed -i -e '2i****************************************************************\' malrep.txt

# zip
zip malscan.zip procPID.txt delbin.txt proc.txt stackmal.txt filedes.txt procmaps.txt pidstats.txt ProccesID.txt lynis.txt clamav.txt rootkit.txt rkhunt.txt lmd.txt malrep.txt
# clean up
rm malscan.zip procPID.txt delbin.txt proc.txt stackmal.txt filedes.txt procmaps.txt pidstats.txt ProccesID.txt lynis.txt clamav.txt rootkit.txt rkhunt.txt lmd.txt malrep.txt
