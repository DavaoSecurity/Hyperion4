#!/bin/bash
# Hyperion v4 UnicornScan
p=$1

docker run kevinbacon/unicornscan:1.0 -o unis.txt
# zip
zip unicornscan.zip unis.txt

# clean up
rm unis.txt
