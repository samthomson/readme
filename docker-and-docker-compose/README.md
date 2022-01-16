# Docker & docker-compose

## Docker

`docker ps`: List all running containers

`docker stop [ID]`: Stop a running/rogue container via its ID (as garnared from running `docker ps`)

`docker images` lists all built images, that may or may not be in use, along with their size.

## docker-compose

`docker-compose up`: start all containers as per docker-compose file, shows output of starting each, CTRL+C to then stop them.

`docker-compose up -d` - detached/headless mode, no output, returned to cmd prompt immediately

`docker-compose down` - reverse of up, stop running containers as specified in local docker compose file. If a container is removed from that file since between running `up` and `down` commands, it will not be stopped.

After changing env values that are passed into containers via the docker-compose.yml file all containers should be stopped and started again so that these values are propogated. ie. `docker-compose down` followed by `docker-compose up [-d]`.

`docker-compose up -d --force-recreate --build <container>` rebuild a specific container, eg after changing its Dockerfile.

### run with overloaded env vars

For instance, bash into a container and overload the LOG_LEVEL (which is otherwise set in the `docker-compose.prod.yml` file): 
`docker-compose -f docker-compose.prod.yml run -e LOG_LEVEL=info api sh`

# related

Delete old containers that aren't used anymore but taking up disk space: `docker system prune`

Even better: `docker system prune -a`

(see here https://stackoverflow.com/questions/17236796/how-to-remove-old-docker-containers)

In production, this folder will swell: `/var/lib/docker/volumes/` could be worth emptying occasionally. Although that will mean you need to restart containers who have lost volumes. In which case use `docker-compose down -v` so that the containers know their volumes are gone, otherwise you'll get missing volume errors.

`docker-compose down -v` to stop containers and volumes. Useful before cleaning out mysql

## rebuild container that stores state in a volume

For example, rebuilding a mysql container as if from scratch, after changing base config.

`docker volume ls` to list all volumes

then `docker volume rm app_mysqldata`

if volume was in use:

```
Error response from daemon: remove app_mysqldata: volume is in use - [e9e49d63a753aac24d1deb8f4511a1acb771417d9c00d8ed85241efcd601b45b]
```

then do `docker stop e9e49d63a753aac24d1deb8f4511a1acb771417d9c00d8ed85241efcd601b45b` but with correct container hash.

## docker stats

To be run on the host [`docker stats`] displays a live summary of running containers' resource usage; CPU, Memory, etc. [docs here](https://docs.docker.com/engine/reference/commandline/stats/).
