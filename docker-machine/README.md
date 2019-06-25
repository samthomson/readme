# docker-machine

## creating a remote docker host with digital ocean

This guide assumes you are using Digital ocean and have an API key.

`test-machine` is used for the machine/host-name. Replace that with what you want to reference the machine with. That name will show up in your DO control panel.

- Inject your Digital ocean API key into the local environemt: `export DO_TOKEN="INSERT_TOKEN_HERE"`
- create remote machine: `docker-machine create --driver=digitalocean --digitalocean-access-token=$DO_TOKEN --digitalocean-size=s-1vcpu-1gb --digitalocean-region=nyc1 test-machine`
- set as 'active machine' (docker-wise) `eval $(docker-machine env test-machine)`
- `docker-machine ip test-machine` to get machines IP, or `docker-machine ls` to see all
- `docker-compose -f docker-compose.prod.yml up -d` (this will build and start the service on the remote machine since you set the remote machine as the active machine)
	- to change back to your normal/local machine use `eval "$(docker-machine env -u)"`

Optional: If your server is basic (eg $5 vps), you may want to enable swap memory. You can do that manually or just run `bash ./bash/enable-swap-remotely.sh` from project root (will transfer a script to the docker-host which then creates a 2GB swap file - script assumes an ubuntu linux server).
Note: That script reads a host var from `.env`
Note: In case you want to validate swap is enabled on the remote docker host, run `docker-machine ssh test-machine "free"` and check the 'Swap:' amounts match the memory amount specified when creating the swap file (2GB if you used the included script).