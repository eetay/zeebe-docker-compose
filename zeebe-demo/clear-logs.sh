#!/bin/bash
CONTAINER=$1
set -x
sudo truncate -s 0 $(docker inspect --format='{{.LogPath}}' $CONTAINER)
