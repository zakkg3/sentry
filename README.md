# sentry
Simple sentry with nginx reverse proxy


Content:
  * docker-compose file
  * Dockerfile(s)
  * config file(s)

    @see https://sentry.io/welcome/
    @see https://github.com/getsentry/sentry


Requirements:

*  Setup is for internal use
* Sentry application should not be publicly accessible
* An nginx proxy container should be publicly accessible,  and proxy the submission of
   browser events through  to the sentry application
* Only allow http requests to the proxy service   for event pushes ( see sentry documentation )

- [] sasa
- [x] dsds

Fork https://gist.github.com/denji/b801f19d95b7d7910982c22bb1478f96
More info https://github.com/getsentry/onpremise/blob/master/docker-compose.yml
