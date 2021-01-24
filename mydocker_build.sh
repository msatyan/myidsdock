docker stop informix
docker rm informix
docker ps -a -q | xargs -n 1 -I {} docker rm {}
docker rmi $( docker images | grep '<none>' | tr -s ' ' | cut -d ' ' -f 3)
docker volume rm $(docker volume ls -qf dangling=true)
cd ./server_ctx
docker build -t idsdb1 .
# docker run  -d -h informix --name ids1c idsdb1 --start
# docker exec -it informix bash

