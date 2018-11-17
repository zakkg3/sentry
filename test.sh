#!/bin/bash
if [ -z "$1" ]
  then
    echo "No argument supplied, please add the AUTH Token."
    echo "using example, test token."
    export SENTRY_DSN=http://73f0839c97034a83be55ca6912659767@localhost:9000/2
else
  export SENTRY_DSN=$1
fi

#sentry-cli send-event -m "This is a test"

eval "$(sentry-cli bash-hook)"
if [ false ]; then
  this-is-a-bash-error
fi
