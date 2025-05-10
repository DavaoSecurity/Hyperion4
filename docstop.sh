#!/bin/bash
Hyperion v4 Docker stop
clear
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
echo " ALL Docker containers stopped and deleted "
