# Install on Ubuntu 22.04.x; 16 GB RAM; 6 Cores; 400 GB SDD; fail2ban; AV; auditd/systat; Lynis harden; sendmail; SMTP only.
# run in Docker; clean up after.
# Docker install latest stable
#clear
#echo " Checking for latest, stable OWASP ZAP Updates.......... "
#echo " "
sudo docker pull ghcr.io/zaproxy/zaproxy:stable
sudo docker pull softwaresecurityproject/zap-stable
sleep 2
#clear
# menu and user input
#echo "                                                                                           "
#echo " ####### #     #    #     #####  ######     ####### ####### ######       #     ###         "
#echo " #     # #  #  #   # #   #     # #     #       #    #     # #     #     ##    #   #        "
#echo " #     # #  #  #  #   #  #       #     #       #    #     # #     #    # #   #     #       "
#echo " #     # #  #  # #     #  #####  ######        #    #     # ######       #   #     #       "
#echo " #     # #  #  # #######       # #             #    #     # #            #   #     #       "
#echo " #     # #  #  # #     # #     # #             #    #     # #            #    #   #        "
#echo " #######  ## ##  #     #  #####  #             #    ####### #          #####   ###         "
#echo "                                                                                           "
#echo "                           By ducatinat nathan@arcadeusops.pro                             "
#echo "                                                                                           "
#echo " Welcome to the OWASP-ZAP script. This will test your target against the latest OWASP Top 10 benchmarks. "
#echo " This script will run an aggressive OWASP-ZAP ATTACK scan. Will take about 15+ mins. "
#echo " The Summary is on first page of your output HTML file, which will automatically be sent to an email of your choice. "
#echo "                                                                                                                     "
#echo " Avoid using free email such as Gmail as it rejects private email servers by default :-(( . If you know how to reconfigure your Gmail "
#echo " spam filters then allow everything from zapstart.uk. "
#echo " ALL EMAILS AND DATA ARE SENT ENCRYPTED WITH CERTBOT/LET'S ENCRYPT technology. ZIP FILES ARE PASSWORD PROTECTED USING THE RSA 2048-bit algorithm."
#echo " To be on the safe side, please use a minimum of 8 characters for the ZIP file password. "
#echo "                                                                                 "
#echo "                                                                                 "
#read -p " Enter the Target e.g. https://example.com : " rtarg
#echo "                                                "
# user input Report name
#read -p " Enter your Report Name e.g. Report1. Saved Report will have extension .html : " rname
#echo "                                                                                  "
# user email to send to
#read -p " Enter the email to send the Report to e.g. me@imaginet.com.ph : " remail
#echo "                                                                    "
#echo " Please wait, could take a few minutes for larger sites  .... "
#echo "                                                              "
# spinner
#sleep 900 &
#PID=$!
#i=1
#sp="/-\|"
#echo -n ' '
#while [ -d /proc/$PID ]
#do
#  printf "\b${sp:i++%${#sp}:1}"
#done
a=$1
b=$2
# Run Baseline Scan
# sudo docker run -t ghcr.io/zaproxy/zaproxy:stable zap-baseline.py -t $rtarg -r $rname
# baseline scan with param file
# sudo docker run -v $(pwd):/zap/wrk/:rw -t ghcr.io/zaproxy/zaproxy:stable zap-baseline.py \
#    -t $rtarg -g gen.conf -r $rname.html
# root privs workaround for Contabo
docker run -v $(pwd):/zap/wrk/:rw --user root ghcr.io/zaproxy/zaproxy:stable zap-full-scan.py -t $1 -g gen.conf -r zapattack.html
#echo " Completing your OWASP scan in a few seconds ......... "
sleep 2
clear
#echo "                                                                                                                             "
#echo " Your HTML Report will now be securely compressed in a password-protected zip file. Please enter a password to open the file."
#echo " REMEMBER YOUR PASSWORD TO OPEN THE REPORT !! It is recommended to a minimum of 8 characters.                                "
#echo "                                                                                                                             "

# zip
pass=$(openssl rand -base64 6)
zip --password ${pass} zapattack.zip zapattack.html
echo " Your password for "$1" zapattack.zip is "${pass}" " | mail -s "Your zapattack.zip Info" $2

# Email Report
echo " OWASP ZAP ATTACK " | mail -s "OWASP ZAP Attack Report for "$1" " -A zapattack.zip $2 
#echo " Email and Password protected Zip file sent successfully to "$remail" ."
##sleep 2
#clear
#echo " Done. Run ./zapstart.sh on another target to Hack The Planet. "
#echo "                                                               "
#echo " PLEASE NOTE:                                           "
#echo " If email did not arrive, close this Powershell/Terminal by typing exit . Then re-open Powershell/Terminal and type..... "
#echo " scp root@194.163.139.59:/root/testreport.html C:\Users\Nathan\Desktop "
#echo " Change testreport.html to the name input, and change Nathan to your Windows User name. "
#echo " scp will securely download the remote OWASP Report .html file to your local Windows Desktop. "
# docker run -v $(pwd):/zap/wrk/:rw --user root ghcr.io/zaproxy/zaproxy:stable zap-baseline.py -t https://imaginet.com.py -g gen.conf -r testreport.html
