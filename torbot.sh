#!/bin/bash
# Hyperion 4 torbot https://github.com/DedSecInside/TorBot
a=$1 # target

cd torBot
python -m venv torbot_venv
source torbot_venv/bin/activate
pip install -r requirements.txt
python torbot -u https://$1 > torbot.txt

# zip
zip torbot.zip torbot.txt

# clean up
rm
 cd ..
