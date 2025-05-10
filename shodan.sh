#!/bin/bash
# Hyperion v4 Shodan with API https://nmap.org/nsedoc/scripts/shodan-api.html Queries Shodan API for given targets
a=$1 # target

nmap -vv -p- -A $1 --script shodan-api -oX sho.xml --script-args 'shodan-api.outfile=shod.csv,shodan-api.apikey=M37DRUG7l4HxA4wDMAmb36Dz1XVgPgZK'
xsltproc sho.xml -o shodan.html
zip shodan.zip shodan.html shod.csv

# clean up
rm sho.xml shodan.html shod.csv
