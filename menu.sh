#!/bin/bash
# Hyperion v4 Bash script list
clear
echo "                                                                              "
echo "              Security Posture and Vulnerability Tests                        "
echo "                        By nwj@inception.bz                                   "
echo "                                                                              "
echo " AS SOME OF THESE SCRIPTS CAN TAKE A LONG TIME THE SYSTEM HAS BEEN REDESIGNED "
echo " ALL SCRIPTS RUN IN THE BACKGROUND WITH LINIX screen. SAFE TO LOGOFF and you  "
echo " can go and do something less boring than looking at screen output :-)        "
echo " Wait for the emailed zipfile. The zipfile password is also emailed to you.   "
echo " BEWARE: The NMAP scripts can take up to 12 hours to complete.                "
echo " The Report filenames are preset.                                             "
echo " This menu allows you to choose the specific tests for your target.           "
echo " Reports will be emailed to you. The available tests are :-                   "
echo "                                                                              "
echo " zapstart.sh  - ZAP Scan Baseline, a base scan for web applications             "
echo " zapattack.sh - ZAP Scan Aggressive attack on web applications                  "
echo " "
echo " TO RUN the above scripts, the target and email are added as script arguments.  "
echo "                                                                                "
echo " For example, to run the OWASP ZAP base test in the background ......           "
echo "           screen -dm ./zapstart.sh https://mytarget.com myemail.com            "
echo "                      NOTE: MUST include the https://                           "
echo "                                                                                "
echo " You can then safely logout (type exit), and wait for the email.                 "
read -p " Press any key to return to the command prompt."
exit 0

#echo " Tests take some time as all ports and the underlying Operating System are tested. "
#echo " ZIP FILES ARE PASSWORD PROTECTED USING THE RSA 2048-bit algorithm.                "
#echo "                                                                                   "
#PS3='Please enter your choice: '
#options=("OWASP ZAP Basic" "OWASP ZAP Aggressive" "DNS Report" "Nmap Firewall" "Nmap HTTP" "Nmap Aggressive" "Vulnerability Scans" "Server" "Update" "PII Files" "Quit")
#select opt in "${options[@]}"
#do
#    case $opt in
#        "OWASP ZAP Basic")
#            ./zapstart.sh
#	    break
#            ;;
#        "OWASP ZAP Aggressive")
#            ./zapattack.sh
#            break
#            ;;
#        "DNS Report")
#            ./dns.sh
#            break
#            ;;
#        "Nmap Firewall")
#            ./nmap2.sh
#            break
#            ;;
#        "Nmap HTTP")
#            ./nmap1.sh
#            break
#            ;;
#        "Nmap Aggressive")
#            ./nmap.sh
#            break
#            ;;
#        "Vulnerability Scans")
#            ./vuln.sh
#            break
#            ;;
#        "Server")
#            ./serv.sh
#            break
#            ;;
#        "Update")
#            ./upd.sh
#            break
#            ;;
#        "PII Files")
#            ./delmail.sh
#            break
#            ;;
#        "Quit")
#            break
#            ;;
#        *) echo "invalid option $REPLY";;
#    esac
#done
