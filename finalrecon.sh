# finalrecon https://github.com/thewhiteh4t/FinalRecon
#!/bin/bash
#
P=$1
Q=$2
#
cd FinalRecon
# docker pull thewhiteh4t/finalrecon
# docker run -it --entrypoint /bin/sh thewhiteh4t/finalrecon python3 finalrecon.py --full https://$1 -w dnsmap.txt -o finalrecon.txt
# python3 finalrecon.py --full https://$1 -o txt
# python3 finalrecon.py --dns https://$1 -o txt -w /root/dnsmap.txt -e php,xml,txt
python3 finalrecon.py --full https://$1 
cd /root/.local/share/finalrecon/dumps
zip finalrecon.zip -r fr_*.*
rm -r fr_*.*
mv finalrecon.zip /root
cd /
cd /root
#
echo " No password for "$1" finalrecon.zip " | mail -s "Your finalrecon.zip Info" -A finalrecon.zip $2

