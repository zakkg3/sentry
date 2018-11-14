#!/bin/sh
printf "verifing Requirements."
if ! [ `sudo systemctl is-active docker` = "active" ];
 then
  echo "We need docker running"
  exit 1;
fi
printf ". Docker OK ."
command -v docker-compose --version >/dev/null 2>&1 || { echo >&2 "docker-compose not found.  Aborting."; exit 1; }
printf ". Docker-compose OK .\n"
echo "Creating secret"
sed -i "s/{{secret}}/$(docker run --rm sentry config generate-secret-key)/" docker-compose.yml
echo "Running stack..."
docker-compose up -d
echo "creating Db and User"
docker-compose exec sentry sentry upgrade
echo "Restarting server"
docker-compose restart sentry
echo "Nginx reverse-proxying in localhost:8000"
