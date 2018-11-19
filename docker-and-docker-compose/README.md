# Docker & docker-compose

## Docker
`docker ps`: List all running containers

`docker stop [ID]`: Stop a running/rogue container via its ID (as garnared from running `docker ps`)

## docker-compose

`docker-compose up`: start all containers as per docker-compose file, shows output of starting each, CTRL+C to then stop them.

`docker-compose up -d` - detached/headless mode, no output, returned to cmd prompt immediately

`docker-compose down` - reverse of up, stop running containers as specified in local docker compose file. If a container is removed from that file since between running `up` and `down` commands, it will not be stopped.

After changing env values that are passed into containers via the docker-compose.yml file all containers should be stopped and started again so that these values are propogated. ie. `docker-compose down` followed by `docker-compose up [-d]`.

`docker-compose up -d --force-recreate --build <container>` rebuild a specific container, eg after changing its Dockerfile.