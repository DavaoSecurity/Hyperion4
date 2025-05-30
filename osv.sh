#!/bin/bash
# Hyperion v4 Use OSV-Scanner to find existing vulnerabilities affecting your project’s dependencies
# install on windows      scoop install osv-scanner
# install from source go install github.com/google/osv-scanner/cmd/osv-scanner@v1
# apt install go (1.21.4+)
# verify source          slsa-verifier verify-artifact ./osv-scanner_1.2.0_linux_amd64 --provenance-path multiple.intoto2.jsonl --source-uri github.com/google/osv-scanner --source-tag v1.2.0
############    mount the directory you want to scan to /src     ##############
docker pull ghcr.io/google/osv-scanner:latest
docker run -it -v ${PWD}:/src ghcr.io/google/osv-scanner -L /src/go.mod --output osvscanner.txt

# zip --password ${pass} osvscanner.zip osvscanner.txt
zip osvscanner.zip osvscanner.txt
# clean up
rm osvscanner.zip osvscanner.txt
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
