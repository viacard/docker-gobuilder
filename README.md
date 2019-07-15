# gobuilder

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


## Building

`docker build --no-cache -t viacard/gobuilder:v1.0 .`

```
Sending build context to Docker daemon  4.096kB
Step 1/12 : FROM golang:alpine
 ---> e04879bf1b7f
Step 2/12 : MAINTAINER mats@viacard.com
 ---> Running in 9b2e7ec17254
Removing intermediate container 9b2e7ec17254
 ---> 57bd9f932e02
Step 3/12 : RUN apk update && apk add --no-cache   gcc   musl-dev   git   upx   ca-certificates   tzdata   sqlite
 ---> Running in 6cdb1d8db1bb
fetch http://dl-cdn.alpinelinux.org/alpine/v3.9/main/x86_64/APKINDEX.tar.gz
fetch http://dl-cdn.alpinelinux.org/alpine/v3.9/community/x86_64/APKINDEX.tar.gz
v3.9.4-64-g48e59c0286 [http://dl-cdn.alpinelinux.org/alpine/v3.9/main]
v3.9.4-57-gb40ea6190b [http://dl-cdn.alpinelinux.org/alpine/v3.9/community]
OK: 9770 distinct packages available
fetch http://dl-cdn.alpinelinux.org/alpine/v3.9/main/x86_64/APKINDEX.tar.gz
fetch http://dl-cdn.alpinelinux.org/alpine/v3.9/community/x86_64/APKINDEX.tar.gz
(1/25) Installing binutils (2.31.1-r2)
(2/25) Installing gmp (6.1.2-r1)
(3/25) Installing isl (0.18-r0)
(4/25) Installing libgomp (8.3.0-r0)
(5/25) Installing libatomic (8.3.0-r0)
(6/25) Installing libgcc (8.3.0-r0)
(7/25) Installing mpfr3 (3.1.5-r1)
(8/25) Installing mpc1 (1.0.3-r1)
(9/25) Installing libstdc++ (8.3.0-r0)
(10/25) Installing gcc (8.3.0-r0)
(11/25) Installing nghttp2-libs (1.35.1-r0)
(12/25) Installing libssh2 (1.8.2-r0)
(13/25) Installing libcurl (7.64.0-r2)
(14/25) Installing expat (2.2.7-r0)
(15/25) Installing pcre2 (10.32-r1)
(16/25) Installing git (2.20.1-r0)
(17/25) Installing musl-dev (1.1.20-r4)
(18/25) Installing ncurses-terminfo-base (6.1_p20190105-r0)
(19/25) Installing ncurses-terminfo (6.1_p20190105-r0)
(20/25) Installing ncurses-libs (6.1_p20190105-r0)
(21/25) Installing readline (7.0.003-r1)
(22/25) Installing sqlite (3.28.0-r0)
(23/25) Installing tzdata (2019a-r0)
(24/25) Installing ucl (1.03-r1)
(25/25) Installing upx (3.95-r1)
Executing busybox-1.29.3-r10.trigger
OK: 131 MiB in 40 packages
Removing intermediate container 6cdb1d8db1bb
 ---> 51e6361ff8a8
Step 4/12 : RUN adduser -D -g '' appuser
 ---> Running in 68c95523a069
Removing intermediate container 68c95523a069
 ---> d1f7a7c52cd8
Step 5/12 : ENV GO111MODULE=on
 ---> Running in cabbc500d2cb
Removing intermediate container cabbc500d2cb
 ---> eb097f7f3fec
Step 6/12 : WORKDIR $GOPATH/src/
 ---> Running in 57f8451f94c7
Removing intermediate container 57f8451f94c7
 ---> 29eda845b83a
Step 7/12 : RUN go install -i -ldflags="-w -s" golang.org/x/crypto/bcrypt
 ---> Running in 49c0c461ef7a
go: finding golang.org/x/crypto/bcrypt latest
go: finding golang.org/x/crypto latest
go: downloading golang.org/x/crypto v0.0.0-20190701094942-4def268fd1a4
go: extracting golang.org/x/crypto v0.0.0-20190701094942-4def268fd1a4
go: finding golang.org/x/net v0.0.0-20190404232315-eb5bcb51f2a3
go: finding golang.org/x/sys v0.0.0-20190412213103-97732733099d
go: finding golang.org/x/crypto v0.0.0-20190308221718-c2843e01d9a2
go: finding golang.org/x/text v0.3.0
go: finding golang.org/x/sys v0.0.0-20190215142949-d0b11bdaac8a
Removing intermediate container 49c0c461ef7a
 ---> 014d6e2ebae4
Step 8/12 : RUN go install -i -ldflags="-w -s" github.com/gorilla/mux
 ---> Running in c77095d64404
go: finding github.com/gorilla/mux v1.7.3
go: downloading github.com/gorilla/mux v1.7.3
go: extracting github.com/gorilla/mux v1.7.3
Removing intermediate container c77095d64404
 ---> 882569769496
Step 9/12 : RUN go install -i -ldflags="-w -s" github.com/gorilla/sessions
 ---> Running in a6f2d1b0805b
go: finding github.com/gorilla/sessions v1.2.0
go: downloading github.com/gorilla/sessions v1.2.0
go: extracting github.com/gorilla/sessions v1.2.0
go: finding github.com/gorilla/securecookie v1.1.1
go: downloading github.com/gorilla/securecookie v1.1.1
go: extracting github.com/gorilla/securecookie v1.1.1
Removing intermediate container a6f2d1b0805b
 ---> 4afa32c69973
Step 10/12 : RUN go install -i -ldflags="-w -s" github.com/gorilla/csrf
 ---> Running in a07285baa8fd
go: finding github.com/gorilla/csrf v1.6.0
go: downloading github.com/gorilla/csrf v1.6.0
go: extracting github.com/gorilla/csrf v1.6.0
go: finding github.com/pkg/errors v0.8.0
go: downloading github.com/pkg/errors v0.8.0
go: extracting github.com/pkg/errors v0.8.0
Removing intermediate container a07285baa8fd
 ---> 34a5ccec5ec3
Step 11/12 : RUN go install -i -ldflags="-w -s" github.com/gorilla/websocket
 ---> Running in 63338a5610b8
go: finding github.com/gorilla/websocket v1.4.0
go: downloading github.com/gorilla/websocket v1.4.0
go: extracting github.com/gorilla/websocket v1.4.0
Removing intermediate container 63338a5610b8
 ---> 1d36f554dfd2
Step 12/12 : RUN CGO_ENABLED=1 go install -ldflags="-w -s" github.com/mattn/go-sqlite3
 ---> Running in 658c059a950a
go: finding github.com/mattn/go-sqlite3 v1.10.0
go: downloading github.com/mattn/go-sqlite3 v1.10.0
go: extracting github.com/mattn/go-sqlite3 v1.10.0
Removing intermediate container 658c059a950a
 ---> 373a60c7c5d2
Successfully built 373a60c7c5d2
Successfully tagged viacard/gobuilder:v1.0
```
