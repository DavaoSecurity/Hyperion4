#!/bin/bash
# Hyperion v4 Sherlock OSINT
u=$3 # username
# docker build -t mysherlock-image .
# docker run --rm -t -v "$PWD/results:/opt/sherlock/results" mysherlock-image -o sherlock.txt $3
# zip
cd sherlock
python3 sherlock $3 > sherl.txt

# pass=$(openssl rand -base64 6)
zip sherlock.zip sherl.txt
mv sherlock.zip /root

# clean up
rm sherl.txt
cd ..
