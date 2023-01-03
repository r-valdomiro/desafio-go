# Builder - base image
FROM golang:1.20rc1-alpine3.17 AS builder

WORKDIR /usr/src/app

# Building executable
COPY app/* .
RUN go mod init hello
RUN go build -v -o bin/hello

# Deploy - base image
FROM scratch

WORKDIR /

# Creating final build
COPY --from=builder /usr/src/app/bin/hello /hello_from_go
ENTRYPOINT [ "/hello_from_go" ]