#!/bin/bash
# nikto https://github.com/sullo/nikto
a=$1
b=$2
# git clone https://github.com/sullo/nikto.git
cd nikto
nikto.pl -update 
nikto -h https://$1 -o nikto.htm
mv nikto.htm /root

pass=$(openssl rand -base64 6)
zip --password ${pass} nikto.zip nikto.htm

echo " Your password for "$1" nikto.zip is "${pass}" " | mail -s "Your nikto.zip Info" $2
echo " Nikto Web Server Scan " | mail -s " Web Server NIKTO Vulnerabilities  "$1" " -A nikto.zip $2
sleep 5
rm nikto.htm nikto.zip
cd ..
