# Sentry
Simple sentry with nginx reverse proxy

## Usage

./run.sh to run the stack. this will create the db's and Username (only the very first time)
So far it support Linux. Next release will suport mac.

## Requirements:
 Docker and docker-compose

## Challange
- [x]  Setup is for internal use. Sentry application should not be publicly accessible
- [x] An nginx proxy container should be publicly accessible,  and proxy the submission of browser events through  to the sentry application
- [x] Only allow http requests to the proxy service for event pushes ( see sentry documentation )
