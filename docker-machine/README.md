# docker-machine

## 1. Creating a remote docker host with digital ocean

This guide assumes you are using Digital ocean and have an API key.

### 1.1 Script based creation

1. `cp ./bash/.env.sample /bash/.env`
2. fill in values in `/bash/.env`
3. `bash ./bash/create-remote-host.sh`
4. Optional: `bash ./bash/enable-swap-remotely.sh`

#### optional

For the VPS/docker-machine to clone private repos, the servers ssh key will need to be added to github.

1. follow both sections [here](https://docs.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent) to generate an ssh key on the server
2. run `cat ~/.ssh/id_ed25519.pub` and copy the contents to clipboard
3. go [here](https://github.com/settings/keys) and add the key to account

### 1.2 Manual setup

`test-machine` is used for the machine/host-name. Replace that with what you want to reference the machine with. That name will show up in your DO control panel.

- Inject your Digital ocean API key into the local environment: `export DO_TOKEN="INSERT_TOKEN_HERE"`
- create remote machine: `docker-machine create --driver=digitalocean --digitalocean-access-token=$DO_TOKEN --digitalocean-size=s-1vcpu-1gb --digitalocean-region=nyc1 test-machine`
- set as 'active machine' (docker-wise) `eval $(docker-machine env test-machine)`
- `docker-machine ip test-machine` to get machines IP, or `docker-machine ls` to see all
- `docker-compose -f docker-compose.prod.yml up -d` (this will build and start the service on the remote machine since you set the remote machine as the active machine)
	- to change back to your normal/local machine use `eval "$(docker-machine env -u)"`

Optional: If your server is basic (eg $5 vps), you may want to enable swap memory. You can do that manually or just run `bash ./bash/enable-swap-remotely.sh` from project root (will transfer a script to the docker-host which then creates a 2GB swap file - script assumes an ubuntu linux server).
Note: That script reads a host var from `.env`
Note: In case you want to validate swap is enabled on the remote docker host, run `docker-machine ssh test-machine "free"` and check the 'Swap:' amounts match the memory amount specified when creating the swap file (2GB if you used the included script).

## 2. Killing a remote docker host

1. Ensure local `.env` file is populated as in 1.1.
2. `bash ./bash/kill-remote-host.sh`


## 3. moving a docker host to another machine

From [this thread](https://github.com/docker/machine/issues/3212#issuecomment-361333628). Use [machine-share](https://github.com/bhurlow/machine-share) to export/import docker machines across machines.

1.  Install npm package globally: `npm i -g machine-share`.
2. export the docker-machine on the original host. `machine-export <machine-name>`
3. transfer the resulting zip file to new machine
3. import the zip file. `machine-import <machine-name>.zip`

run `docker-machine ls` to check it's been added.