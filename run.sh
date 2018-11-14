#!/bin/sh
echo "Creating secret"
sed -i "s/{{secret}}/$(docker run --rm sentry config generate-secret-key)/" docker-compose.yml
echo "Running stack..."
docker-compose up -d
echo "creating Db and User"
docker-compose exec sentry sentry upgrade
echo "Restarting server"
docker-compose restart sentry
echo "Nginx reverse-proxying in localhost:8000"
