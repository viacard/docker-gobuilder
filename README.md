# gobuilder

A container for fast(er) builds of golang-based applications.  Using the golang:alpine as the base image and then git, gcc and some additional packaged added. On top of that some larger and useful go packages are added so they don't need to be pulled & compiled at build time.

This image was in particular made for speeding up the mattn/go-sqlite3 package since it must be build with cgo enabled which takes a long time.

## Repo

All files can be found at https://github.com/viacard/docker-gobuilder

## Dockerfile

```
FROM golang:alpine
MAINTAINER mats@viacard.com

# Install git + SSL ca certificates.
# Git is required for fetching the dependencies.
RUN apk update && apk add --no-cache \
  gcc \
  musl-dev \
  git \
  upx \
  ca-certificates \
  tzdata \
  sqlite

# Create unprivileged appuser
RUN adduser -D -g '' appuser

# We want to use modules even if bulding in $GOPATH
ENV GO111MODULE=on
WORKDIR $GOPATH/src/

# Install modules
RUN go install -i -ldflags="-w -s" golang.org/x/crypto/bcrypt
RUN go install -i -ldflags="-w -s" github.com/gorilla/mux
RUN go install -i -ldflags="-w -s" github.com/gorilla/sessions
RUN go install -i -ldflags="-w -s" github.com/gorilla/csrf
RUN go install -i -ldflags="-w -s" github.com/gorilla/websocket
RUN CGO_ENABLED=1 go install -ldflags="-w -s" github.com/mattn/go-sqlite3
```

## Release history

- v1.0 July 15 2019 - Initial release
  - alpine 3.9
  - gcc 8.3.0-r0
  - go 1.12.6
  - golang.org/x/crypto v0.0.0-20190701094942
  - gorilla/mux v1.7.3
  - gorilla/sessions v1.2.0
  - gorilla/securecookie v1.1.1
  - gorilla/csrf v1.6.0
  - gorilla/websocket v1.4.0
  - mattn/go-sqlite3 v1.10.0

