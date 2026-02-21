FROM debian:trixie-slim

ARG TARGETARCH
ARG TARGETPLATFORM
ARG VERSION
ARG CHANNEL

SHELL ["/bin/bash", "-e", "-x", "-u", "-c"]

ENV DEBIAN_FRONTEND=noninteractive

## Install dependencies
RUN   apt-get update; \
      apt-get install -o APT::Keep-Downloaded-Packages="false" -y \
          ca-certificates curl wget tar unzip xz-utils bzip2 coreutils procps \
          iproute2 iputils-ping net-tools socat jq yq git git-lfs gnupg tini \
          tzdata locales libssl3t64 libcurl4t64 libsqlite3-0 libzstd1 \
          libsdl2-2.0-0 libsdl1.2debian libfontconfig1 libicu76 libc6 \
          libatomic1 liblua5.3-0 libgdiplus gdb libc++1 libc++abi1 libunwind8 \
          libgcc-s1; \
      \
      apt-get clean; \
      rm -rf /var/lib/apt/lists/*;

ADD   --chmod=0755 ./run.sh /usr/local/bin

USER        nobody:nogroup
ENV         HOME=/game
WORKDIR     /game
VOLUME      /game

ENTRYPOINT  ["/usr/bin/tini", "-g", "--"]
CMD         [ "/usr/local/bin/run.sh" ]
