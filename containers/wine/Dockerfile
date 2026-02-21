FROM  ghcr.io/krobertson/game-containers/debian:rolling

USER  root

ARG   WINE_DIST="trixie"
ARG   WINE_BRANCH="stable"

## Install Wine
RUN   sed -i -e 's/ main / main contrib non-free /' -e 's/ main$/ main contrib non-free/' /etc/apt/sources.list.d/debian.sources; \
      dpkg --add-architecture i386; \
      \
      apt-get update; \
      apt-get install -o APT::Keep-Downloaded-Packages="false" -y --no-install-recommends \
          cabextract winbind xvfb xauth libxi6 wine-binfmt libsdl2-2.0-0 libsdl2-2.0-0:i386; \
      \
      install -d -m 0755 /etc/apt/keyrings; \
      wget -qO- https://dl.winehq.org/wine-builds/winehq.key | gpg --dearmor -o /etc/apt/keyrings/winehq-archive.key -; \
      wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/debian/dists/${WINE_DIST}/winehq-${WINE_DIST}.sources; \
      \
      apt-get update; \
      apt-get install -o APT::Keep-Downloaded-Packages="false" -y --install-recommends \
          winehq-${WINE_BRANCH} winetricks; \
      \
      apt-get clean; \
      rm -rf /var/lib/apt/lists/*;

ADD   --chmod=0755 ./setupwine.sh /usr/local/bin

ENV   XDG_RUNTIME_DIR="/tmp" \
      WINEPREFIX="/game/wine/.wine" \
      WINEARCH="win64" \
      WINEDEBUG="-all"

USER  nobody:nogroup
