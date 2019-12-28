#!bin/bash
# this script should be run from anywhere, since we define and use the `$SCRIPTPATH` var

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

# read env var to get host name
source $SCRIPTPATH/.env

echo "we'll enable swap on $DOCKER_HOST"

# copy the enable swap bash script to the remote docker host (vps)
docker-machine scp $SCRIPTPATH/swap.sh $DOCKER_HOST:/enable-swap-locally.sh

# now remotely run that script on the remote host
docker-machine ssh $DOCKER_HOST "bash /enable-swap-locally.sh"