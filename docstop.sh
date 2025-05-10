#!/bin/bash
clear
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
echo " ALL Docker containers stopped and deleted "

