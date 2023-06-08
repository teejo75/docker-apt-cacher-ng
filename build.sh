#!/bin/sh
sudo docker build --no-cache --progress=plain -t local/apt-cacher-ng . 2>&1 | tee build.log
