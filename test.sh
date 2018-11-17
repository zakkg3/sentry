#!/bin/bash
if [ -z "$1" ]
  then
    echo "No argument supplied, please add the AUTH Token."
    echo "using example, test token."
    export SENTRY_DSN=http://73f0839c97034a83be55ca6912659767@localhost:8000/1
else
  export SENTRY_DSN=http://$1@localhost:8000/4
fi
command -v sentry-cli --version >/dev/null 2>&1 || { echo >&2 "sentry-cli not found.  Aborting."; exit 1; }

echo "Sending a test error..."
sentry-cli send-event -m "This is a test" -m "Another thing here"
echo "Catching Bash error..."
eval "$(sentry-cli bash-hook)"
if [ false ]; then
  this-is-a-bash-error
fi
