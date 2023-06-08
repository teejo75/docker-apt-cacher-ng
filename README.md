![GitHub tag (latest SemVer)](https://img.shields.io/github/v/tag/teejo75/docker-apt-cacher-ng?sort=semver)
![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/teejo75/docker-apt-cacher-ng/docker-publish.yml)

## Dockerized apt-cacher-ng

This image is based on Debian-slim and should cache most apt repositories, including https. It provides 
access to the full `/etc/apt-cacher-ng` folder as well as the cache folder. Just mount the appropriate volumes.


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

NOTE: If you find you're getting dns lookup failures from the cache when trying to do an `apt update`, connect to the cache host and ping the specific server that is failing, then try running your apt update again.
It's a strange issue and is not specific to the container. I have seen this happen on my non-dockerized cache and may be particular to the version of apt-cacher-ng.

## Upgrading
If you have used this image prior to v0.04, please delete the etc-apt-cacher-ng folder/volume and let the container re-create it. You might need to delete the data folder too if you're having issues.

(Still trying to solve some niggly issues, but need to wait for some system updates to be available to properly test)
