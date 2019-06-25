#!bin/bash
# this script should be run from project root

# read env var to get host name
source .env

# copy the enable swap bash script to the remote docker host (vps)
docker-machine scp ./bash/swap.sh $DOCKER_HOST:/enable-swap-locally.sh

# now remotely run that script on the remote host
docker-machine ssh $DOCKER_HOST "bash /enable-swap-locally.sh"