docker-compose down
docker volume prune
docker-compose up -d
sleep 20
./patch-postgres.sh 
docker-compose restart zeebe-worker

