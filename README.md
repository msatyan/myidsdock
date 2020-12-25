### Informix Docker Build
Copy `iif.14.10.fc1.tar` file into `server_ctx/` and run `mydocker_build.sh` script to create docker image.


```bash
# make sure Informix server install image exist at
ls -l myidsdock/server_ctx/iif.14.10.fc1.tar
```

### Optional initial cleanup
```bash
# you may need 'container login' for example
docker login
# WARNING! Your password will be stored unencrypted in ~/.docker/config.json.
# docker logout

docker images

# incase if you have to clean the existing images
docker system prune
docker system prune -a
```


### docker build
```bash
# start the build

cd myidsdock
./mydocker_build.sh

# If above build is success then check the image
docker images
# REPOSITORY          TAG       IMAGE ID       CREATED          SIZE
# idsdock/informix   latest    d29abe509358   39 minutes ago   1.7GB
# centos              7         8652b9f0cb4c   5 weeks ago      204MB
```


### Run
```bash
# Show both running and stopped containers
docker ps -a
# CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES


# run the docker by assigning a container name = ids1c
docker run -it -d --name ids1c -p 9099:60000 idsdock/informix
# docker run -d -h informix --name ids1c idsdock/informix --start

# e7bf4d895af5cf7c41b4e1021c5112b80844b8682960c60e79a48b0f876474d2

docker ps -a
# CONTAINER ID   IMAGE               COMMAND                  CREATED         STATUS         PORTS       NAMES
# e7bf4d895af5   idsdock/informix   "/opt/ibm/boot.sh --…"   7 seconds ago   Up 6 seconds   60000/tcp   ids1c

# runs a new command in a running container.
docker exec -it ids1c /bin/bash
# [root@e7bf4d895af5 ibm]

####  we are inside the container now ####

# if you want to be user informix
# su informix

onstat -
# IBM Informix Dynamic Server Version 14.10.FC3DE -- On-Line -- Up 00:04:01 -- 172660 Kbytes

# exit from the container
exit
```


### stop the container
```bash
docker ps -a
# CONTAINER ID   IMAGE               COMMAND                  CREATED         STATUS         PORTS       NAMES
# e7bf4d895af5   idsdock/informix   "/opt/ibm/boot.sh --…"   7 minutes ago   Up 7 minutes   60000/tcp   ids1c

# to stop the container
docker stop ids1c
# ids1c

# to start the container
# docker start ids1c

docker ps -a
# CONTAINER ID   IMAGE               COMMAND                  CREATED         STATUS                       PORTS     NAMES
# e7bf4d895af5   idsdock/informix   "/opt/ibm/boot.sh --…"   7 minutes ago   Exited (137) 3 seconds ago             ids1c
```


### delete the container
```bash
docker container rm ids1c
# ids1c

docker ps -a
# CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
```

### Cleanup
```bash
# incase if you have to clean the existing images
docker system prune
docker system prune -a

# logout from container registry
docker logout
```

