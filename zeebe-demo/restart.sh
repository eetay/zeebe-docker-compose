#!/bin/bash -x 
docker-compose down
docker volume prune -f
docker-compose up -d
sleep 20
./patch-postgres.sh 
docker-compose restart zeebe-worker
docker-compose restart monitor
