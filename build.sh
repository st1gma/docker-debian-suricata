#!/bin/bash

USER=1000
GROUP=1000

## create necessary directories
mkdir /data
mkdir /data/{configs,logs,pcaps}

## chown them to the docker user
chown -R $USER:$GROUP /data

## build suri docker
build . -t suri:latest
