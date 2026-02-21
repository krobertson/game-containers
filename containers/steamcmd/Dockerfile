FROM  ghcr.io/krobertson/game-containers/debian:rolling

USER root

RUN   dpkg --add-architecture i386; \
      apt-get update; \
      apt-get install -o APT::Keep-Downloaded-Packages="false" -y --no-install-recommends \
          libsdl2-2.0-0:i386; \
      \
      apt-get clean; \
      rm -rf /var/lib/apt/lists/*;

ADD   --chmod=0755 ./steamcmd.sh /usr/local/bin
USER  nobody:nogroup
CMD   ["/usr/local/bin/steamcmd.sh"]
