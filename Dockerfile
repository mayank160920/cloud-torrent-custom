ADD file:85ed2ac9d10c6f076a01f29e72b653675994c6fcfb90f0e6b88368c0262893fa in /
CMD ["/bin/sh"]
LABEL maintainer=dev@jpillora.com
ENV GOPATH=/go
ENV NAME=cloud-torrent
ENV PACKAGE=github.com/jpillora/cloud-torrent
ENV PACKAGE_DIR=/go/src/github.com/jpillora/cloud-torrent
ENV GOLANG_VERSION=1.9.1
ENV GOLANG_SRC_URL=https://golang.org/dl/go1.9.1.src.tar.gz
ENV GOLANG_SRC_SHA256=a84afc9dc7d64fe0fa84d4d735e2ece23831a22117b50dafc75c1484f1cb550e
ENV PATH=/go/bin:/usr/local/go/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV CGO_ENABLED=0
RUN set -ex
   &&  apk update
   &&  apk add ca-certificates
   &&  apk add --no-cache --virtual .build-deps bash gcc musl-dev openssl git go curl
   &&  curl -s https://raw.githubusercontent.com/docker-library/golang/221ee92559f2963c1fe55646d3516f5b8f4c91a4/1.9/alpine3.6/no-pic.patch -o /no-pic.patch
   &&  cat /no-pic.patch
   &&  export GOROOT_BOOTSTRAP="$(go env GOROOT)"
   &&  wget -q "$GOLANG_SRC_URL" -O golang.tar.gz
   &&  echo "$GOLANG_SRC_SHA256 golang.tar.gz" | sha256sum -c -
   &&  tar -C /usr/local -xzf golang.tar.gz
   &&  rm golang.tar.gz
   &&  cd /usr/local/go/src
   &&  patch -p2 -i /no-pic.patch
   &&  ./make.bash
   &&  mkdir -p $PACKAGE_DIR
   &&  git clone https://$PACKAGE.git $PACKAGE_DIR
   &&  cd $PACKAGE_DIR
   &&  go build -ldflags "-X main.VERSION=$(git describe --abbrev=0 --tags)" -o /usr/local/bin/$NAME
   &&  apk del .build-deps
   &&  rm -rf /no-pic.patch $GOPATH /usr/local/go
ENTRYPOINT ["cloud-torrent"]
