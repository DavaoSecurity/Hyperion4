# torbot https://github.com/DedSecInside/TorBot
#!/bin/bash
a=$1
b=$2

cd torBot
python -m venv torbot_venv
source torbot_venv/bin/activate
pip install -r requirements.txt
python torbot -u https://$1 > torbot.txt

zip torbot.zip torbot.txt
echo " No password for "$1" torbot.zip " | mail -s " Dark Web Recon for "$1" " -A torbot.zip $2
