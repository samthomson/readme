#!bin/bash

# read env var to get host details
SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
source $SCRIPTPATH/.env

# check env vars
echo "we'll create a VPS called $DOCKER_HOST"
echo "in region: $DO_DROPLET_REGION"
echo "of size: $DO_DROPLET_SIZE"

# create remote machine
docker-machine create --driver=digitalocean --digitalocean-access-token=$DO_TOKEN --digitalocean-size=$DO_DROPLET_SIZE --digitalocean-region=$DO_DROPLET_REGION --digitalocean-image=ubuntu-18-04-x64 --engine-install-url=https://releases.rancher.com/install-docker/19.03.9.sh $DOCKER_HOST
