#!/bin/bash
# Hyperion v4 Windows Exploits
l=$1 # a loose representaion of Windows OS eg windows xp home edition sp2

# windows-exploit-suggester https://github.com/AonCyberLabs/Windows-Exploit-Suggester
# on victim Windows machine run systeminfo > systeminfo.txt
cd Windows-Exploit-Suggester
windows-exploit-suggester --update
# update to Microsoft exploit database
windows-exploit-suggester --database 2024-01-01-mssb.xls --ostext ''$1'' > wes.txt
sed -i '1i Windows Exploit Code \n---------------------------------------' wexploit.txt

# zip
zip wexp.zip wexploit.txt

# cleanup
rm wes.txt wexploit.txt
