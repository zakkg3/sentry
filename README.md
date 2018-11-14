# sentry
Simple sentry with nginx reverse proxy

## usage

./run.sh to run the stack. this will create the db's and Username (only the very first time)

## Requirements:
 Docker and docker-compose

## Challange
- [ ]  Setup is for internal use. Sentry application should not be publicly accessible
- [x] An nginx proxy container should be publicly accessible,  and proxy the submission of browser events through  to the sentry application
- [ ] Only allow http requests to the proxy service for event pushes ( see sentry documentation )


Fork https://gist.github.com/denji/b801f19d95b7d7910982c22bb1478f96
More info https://github.com/getsentry/onpremise/blob/master/docker-compose.yml
https://docs.sentry.io/server/nginx/
