#!/bin/bash
# Docker install latest stable
clear
echo " Checking for OWASP ZAP Updates.......... "
echo " "
sudo docker pull ghcr.io/zaproxy/zaproxy:stable
sudo docker pull softwaresecurityproject/zap-stable
clear

# user input target
echo " "
echo " Welcome to the OWASP-ZAP script. This will test your target against the OWASP Top 10. "
read -p "Enter the Target e.g. https://example.com : " rtarg
echo " "

# user input Report name
read -p "Enter your Report Name e.g. Report1 : " rname
echo " "

# user email to send to
# read -p "Enter the email to send the Report to e.g. me@myemail.com : " remail
echo " "
echo "Please wait .... "
# spinner
sleep 160 &
PID=$!
i=1
sp="/-\|"
echo -n ' '
while [ -d /proc/$PID ]
do
  printf "\b${sp:i++%${#sp}:1}"
done

# Run Baseline Scan
# sudo docker run -t ghcr.io/zaproxy/zaproxy:stable zap-baseline.py -t $rtarg -r $rname

# baseline scan with param file
sudo docker run -v $(pwd):/zap/wrk/:rw -t ghcr.io/zaproxy/zaproxy:stable zap-baseline.py \
    -t $rtarg -g gen.conf -r $rname.html

# Email Report
# Sending the email with attachment
# echo -e "Look at the Summary at top of HTML file" | mail -s "OWASP ZAP Report" -A $rname >clear
# echo "Email sent successfully."
