#!/usr/bin/env bash
# Nathan Jones nwj@inception.bz
# INSTALL FIRST https://github.com/thewhiteh4t/FinalRecon https://github.com/powerexploit/Ashok https://github.com/laramies/theHarvester/wiki/Installation
# git clone https://github.com/thewhiteh4t/FinalRecon.git
# cd FinalRecon
# pip3 install -r requirements.txt
#
#

r=$1
k=$2

# NOTE!!!! Don't forget to insert your API Keys in theHarvester."

# dnsenum
dnsenum $1 -o dnsrec.xml
xsltproc dnsrec.xml -o dnsrec.html
# theHarvester
cd theHarvester
python3 theHarvester.py -d $1 -f harvest.xml -b ALL
mv harvest.xml /root
xsltproc harvest.xml -o harvest.html
cd ..
# sn1per https://github.com/1N3/Sn1per
cd Sn1per
sniper -u
sniper -t $1 # normal mode
# sniper -t $1 -o -re # OSINT and RECON
# sniper -t $1 -m stealth -o -re # Stealth OSINT and RECON
zip -r sniper.zip loot
mv sniper.zip /root
cd ..
# reconFTW https://github.com/six2dez/reconftw#a-in-your-pcvpsvm
cd reconftw/
./reconftw.sh -d $1 -a -o /root/RFTW
cd ..
zip -r RFTW.zip /root/RFTW
# all dns
sudo nmap -p - --script dns* $1 -oX dns.xml
xsltproc dns.xml -o dns.html
# all Discovery
sudo nmap -p - --script discovery $1 -oX disc.xml
xsltproc disc.xml -o disc.html
# trape chnage port 80 eg 443
# cd trape
# python3 trape.py --url $1 --port 80 > trape.txt
# sed -i -e '1iTrape files\' trape.txt
# sed -i -e '2i***************************\' trape.txt
# mv trape.txt /root
# cd ..
# photon
cd Photon 
python3 photon.py --update
python3 photon.py -u $1 --dns --keys -l 5 -o /root/Photon/Results
cd Results
zip photon.zip *.*
mv photon.zip /root
cd /

# poetry run python run.py -h # for help
# nmapAutomator
cd nmapAutomator
./nmapAutomator.sh --host $1 --type All > nmA.txt
mv nmA.txt /root
cd ..
#
cat nmA.txt ashok.txt > allrep.txt
sed -i -e '1iAll OSINT .txt files\' allrep.txt
sed -i -e '2i******************************************************\' allrep.txt

# zip
pass=$(openssl rand -base64 6)
zip --password ${pass} OSINT.zip allrep.txt dnsrec.html harvest.html dns.html disc.html sniper.zip RFTW.zip photon.zip

# Email Report and Password
echo " OSINT Report OSINT.zip" | mail -s "General OSINT Report for "$1" " -A OSINT.zip $2
echo " Your password for "$1" OSINT.zip is "${pass}" " | mail -s "Your OSINT.zip Info" $2

docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)

