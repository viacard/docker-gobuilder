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
	