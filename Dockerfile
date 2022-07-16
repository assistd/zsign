# build
FROM ubuntu:20.04
LABEL maintainer=zhongkaizhu

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends  \
    mingw-w64 patch \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /udt

CMD echo $PATH
