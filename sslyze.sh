#!/bin/bash
# Hyperion v4 sslyze https://github.com/nabla-c0d3/sslyze
h=$1 # target

docker run --rm -it nablac0d3/sslyze:5.0.0 $1 > sslyze.txt
# zip

zip sslyze.zip sslyze.txt

# clean up
rm sslyze.txt
