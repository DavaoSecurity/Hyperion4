#!/bin/bash

# Install tools
echo " "
echo " Make sure you have setup your outgoing SMTP mail server as per the instructions on screen. "
echo " You need to specify your email server logon credentials to allow SMTP traffic."
echo " "
sudo apt update
sudo apt-get install net-tools nload mailutils ssmtp epel-release -y
# nano /etc/ssmtp/ssmtp.conf
# change email addresses to your Gmail account
