#!/bin/bash
# Hyperion v3.x by ducatinat nathan.jones@arcadeusops.com; Kali/ArchLinux/Blackarch server where appropriate, otherise Ubuntu

sudp apt install git docker apparmor wget clamav curl nano htop ncdu libapache2-mod-evasive libapache2-mod-security2 python3-pip
chmod +x get-pip.py
python get-pip.py

sudo nmap --script-update
sudo nmap --script-updatedb
