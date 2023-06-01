![GitHub tag (latest SemVer)](https://img.shields.io/github/v/tag/teejo75/docker-apt-cacher-ng?sort=semver)
![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/teejo75/docker-apt-cacher-ng/docker-publish.yml)

## Dockerized apt-cacher-ng

Exactly what it says. The image is based on Debian-slim and should cache most apt repositories, including https.

This image provides access to the full /etc/apt-cacher-ng folder as well as the cache folder, just mount the appropriate volumes.


Use the following simple `docker-compose.yml` to bring the service up.
```yaml
version: '3'

services:
  apt-cacher-ng:
    restart: always
    image: ghcr.io/teejo75/apt-cacher-ng:latest
    ports:
    - "3142:3142"
    volumes:
    - ./data:/var/cache/apt-cacher-ng
    - ./etc-apt-cacher-ng:/etc/apt-cacher-ng
```

To configure your installations to use this cache, create a file called `02proxy` in `/etc/apt/apt.conf.d` with the following contents:

`Acquire::http::Proxy "http://<ip of docker host>:3142";`

Use apt as normal.

