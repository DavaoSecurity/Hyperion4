#!/bin/bash
l=$1 # a loose representaion of Windows OS eg windows xp home edition sp2
m=$2
# windows-exploit-suggester https://github.com/AonCyberLabs/Windows-Exploit-Suggester
# on victim Windows machine run systeminfo > systeminfo.txt
cd Windows-Exploit-Suggester
windows-exploit-suggester --update
# update to Microsoft exploit database
windows-exploit-suggester --database 2024-01-01-mssb.xls --ostext ''$1'' > wes.txt
sed -i '1i Windows Exploit Code \n---------------------------------------' wexploit.txt

# zip
pass=$(openssl rand -base64 6)
zip --password ${pass} wexp.zip wexploit.txt

# Email Report and Password
echo " Search For Windows Exploits wexp.zip" | mail -s "Windows Exploit Report for "$1" " -A wexp.zip $2
echo " Your password for "$1" wexp.zip is "${pass}" " | mail -s "Your wexp.zip Info" $2
