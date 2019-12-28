#!bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
# read env var to get host name
source $SCRIPTPATH/.env

# gracefully stop the running machine
docker-machine stop $DOCKER_HOST

# remove it in one, ignoring the 'are you sure' warning
docker-machine rm -y $DOCKER_HOST