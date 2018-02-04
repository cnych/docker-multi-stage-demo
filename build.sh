#!/bin/sh
echo Building cnych/docker-multi-stage-demo:build

docker build -t cnych/docker-multi-stage-demo:build . -f Dockerfile.build

docker create --name extract cnych/docker-multi-stage-demo:build  
docker cp extract:/go/src/app/app-server ./app-server  
docker rm -f extract

echo Building cnych/docker-multi-stage-demo:old

docker build --no-cache -t cnych/docker-multi-stage-demo:old . -f Dockerfile.old
rm ./app-server