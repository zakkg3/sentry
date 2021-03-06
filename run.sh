#!/bin/bash

printf "verifing Requirements.\n"
unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    CYGWIN*)    machine=Cygwin;;
    MINGW*)     machine=MinGw;;
    *)          machine="UNKNOWN:${unameOut}"
esac
echo Machine ${machine} detected

if [ ${machine} == "Mac" ] ; then
  docker info --format "{{.OperatingSystem}}" | grep -q "Docker for Mac"
  if [[ $? -eq 0 ]]; then
      echo "Docker for Mac!"
  else
      echo "Docker for mac not detected. Aborting."
      exit 1;
  fi
elif [ ${machine} == "Linux" ] ; then
  if [ `sudo systemctl is-active docker` = "active" ];
   then
     echo "Docker for Linux"
   else
    echo "Docker for Linux not running. Aborting."
    exit 1;
  fi
fi
printf "Docker OK..."
command -v docker-compose --version >/dev/null 2>&1 || { echo >&2 "docker-compose not found.  Aborting."; exit 1; }
printf "Docker-compose OK .\n"

if [[ $1 == "--init" ]] ; then
  echo "running initialization"
  echo "Creating secret"
  docker pull sentry
  sed -i "s/{{secret}}/$(docker run --rm sentry config generate-secret-key)/" .env
  echo "creating volumes"
  docker volume create --name=sentry-data && docker volume create --name=sentry-postgres
fi

echo "Running stack..."
docker-compose up -d

if [[ $1 == "--init" ]] ; then
  echo "Creating Db and User"
  docker-compose exec sentry sentry upgrade
  echo "Restarting server"
  docker-compose restart sentry
fi
echo "Nginx reverse-proxying in localhost:8000"
IP=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $(docker-compose ps -q sentry))
echo For internal Access use http://$IP:9000
#TO-DO if there is arguments install docker-compose exec sentry pip install sentry-slack
