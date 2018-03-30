#!/bin/bash

# http://www.dwmkerr.com/learn-docker-by-building-a-microservice/
docker pull hypriot/rpi-mysql:latest
docker images
docker run --name db -d -e MYSQL_ROOT_PASSWORD=root -p 3306:3306 hypriot/rpi-mysql
docker ps
docker exec -it db /bin/bash
