# docker-multi-stage-demo
this project is a demo of docker multi stage build.


## docker images

`cnych/docker-multi-stage-demo:latest`


## run
```
$ docker run --rm -p 8080:8080 cnych/docker-multi-stage-demo:latest
```

after run successfully, you can visit `http://127.0.0.1:8080/ping` in browser.


## Dockerfile
you can define multi stage in Dockerfile:
```
FROM golang AS build-env
ADD . /go/src/app
WORKDIR /go/src/app
RUN go get -u -v github.com/kardianos/govendor
RUN govendor sync
ENV GOOS=linux
ENV GOARCH=386
RUN go build -v -o /go/src/app/app-server


FROM alpine
RUN apk add -U tzdata
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai  /etc/localtime
COPY --from=build-env /go/src/app/app-server /usr/local/bin/app-server
EXPOSE 8080
CMD [ "app-server" ]
```