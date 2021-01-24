### Informix Docker Build
Copy `iif.14.10.fc1.tar` file into `server_ctx/` and run `mydocker_build.sh` script to create docker image.


```bash
# make sure Informix server install image exist at
cd myidsdock
ls -l server_ctx/iif.14.10.fc1.tar
ls -l server_ctx/wsBlade1.bld
```

### Optional initial cleanup
```bash
# you may need 'container login' for example
docker login
# WARNING! Your password will be stored unencrypted in ~/.docker/config.json.

# logout
docker logout

# get list of all local images 
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
```


### Run
```bash
# Show both running and stopped containers
docker ps -a

# run the docker by assigning a container name = idsdb-cnt1
docker run -it -d --name idsdb-cnt1 -p 9099:60000 idsdb1

# runs a new command in a running container.
docker exec -it idsdb-cnt1 /bin/bash

# if you want to be user informix
# su informix

onstat -
# IBM Informix Dynamic Server Version 14.10.FC3DE -- On-Line -- Up 00:04:01 -- 172660 Kbytes

# exit from the container
exit
```

```
# ls -l /opt/ibm/data/log/informix.log
"SERVER=informix;DATABASE=db1;HOST=192.168.238.3;SERVICE=9099;PROTOCOL=onsoctcp;UID=informix;PWD=mypwd123;"
```


### stop the container
```bash
docker ps -a

# to stop the container
docker stop idsdb-cnt1

# to start the container
docker start idsdb-cnt1

# delete the container
docker container rm idsdb-cnt1
```



### Create a new docker image from the container and push to docker hub
```bash
docker ps -a | grep idsdb1
# 03015aeabf25

# docker commit [OPTIONS] CONTAINER [REPOSITORY[:TAG]]
docker commit 03015aeabf25  xuser1/idsdb1

# to push the image to docker hub
# docker push [OPTIONS] NAME[:TAG]
docker push xuser1/idsdb1
```


### Pull the docker image from the docker hub and run
```bash
docker pull xuser1/idsdb1
docker run -it -d --name idsdb-cnt1 -p 9099:60000 -d xuser1/idsdb1
# https://cloud.docker.com/repository/docker/xuser1/idsdb1
```


### Cleanup
```bash
# incase if you have to clean the existing images
docker system prune
docker system prune -a

# logout from container registry
docker logout
```

