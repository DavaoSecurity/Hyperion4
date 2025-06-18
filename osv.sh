#!/bin/bash
# Use OSV-Scanner to find existing vulnerabilities affecting your project’s dependencies

# install on windows      scoop install osv-scanner
# install from source go install github.com/google/osv-scanner/cmd/osv-scanner@v1
# apt install go (1.21.4+)
# verify source          slsa-verifier verify-artifact ./osv-scanner_1.2.0_linux_amd64 --provenance-path multiple.intoto2.jsonl --source-uri github.com/google/osv-scanner --source-tag v1.2.0


############    mount the directory you want to scan to /src     ##############
docker pull ghcr.io/google/osv-scanner:latest
docker run -it -v ${PWD}:/src ghcr.io/google/osv-scanner -L /src/go.mod --output osvscanner.txt

# zip

# pass=$(openssl rand -base64 6)
# zip --password ${pass} osvscanner.zip osvscanner.txt
zip osvscanner.zip osvscanner.txt
# Email Report and Password
echo " OSV Scanner Report osvscanner.zip" | mail -s "OSV Report for Cerebus " -A osvscanner.zip ducatinat@protonmail.com
# echo " Your password for "$1" osvscanner.zip is "${pass}" " | mail -s "Your osvscanner.zip Info" $2
sleep 5
rm osvscanner.zip osvscanner.txt
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
