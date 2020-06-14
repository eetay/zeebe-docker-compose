#!/bin/bash -x 
docker-compose down
eq --dry 'indices | grep zeebe | delete-by-query "*"'
eq 'indices | grep zeebe | delete-by-query "*"'
docker volume prune -f
docker-compose up -d
sleep 40
./patch-postgres.sh 
docker-compose restart zeebe-worker
docker-compose restart monitor
