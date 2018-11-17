# Sentry
Simple sentry with nginx reverse proxy


## Quick start

1- clone the repo in your local drive.

    git clone https://github.com/zakkg3/sentry
2- make the script executables

    chmod +x run.sh && chmod + x test.sh
3- Initialize dbs, create user and docker volumes. skip the "--init" argument if you already run it before.

    ./run.sh --init
4- tests push events

    ./test.sh

## Requirements:

 Docker 
 docker-compose
 sentry-cli


## Access the sentry server internally

The last output of the run script is the internal url to access sentry web server directly. If you missed access the internal ip address on port 9000, get the ip with this command:

`docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $(docker-compose ps -q sentry)`

## Testing a push-event

This script will push 2 new events to the project 2. In the image above, the project "ottonova" (id 2)
To use the test script you may need to create a auth_token and pass it as an argument to the script 


    ➜  sentry git:(master) ✗ ./test.sh 73f0839c97034a83be55ca6912659767
    Sending a test error...
    db9fd7d4-6944-4f28-a052-37efd8737a26
    Catching Bash error...
    ./test.sh: line 17: this-is-a-bash-error: command not found


## Testing endpoints

`curl -i -X POST localhost:8000/2`

It should respond 301. Other endpoint than /[1-3] and other method than POST will return 405 Not allowed.
