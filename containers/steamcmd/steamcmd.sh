#!/bin/bash

set -e

if [ ! -e /game/steamcmd ]; then
  (
    ## download and install steamcmd
    cd /tmp
    mkdir -p /game/steamcmd
    curl -sSL -o steamcmd.tar.gz https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz
    tar -xzvf steamcmd.tar.gz -C /game/steamcmd
    rm steamcmd.tar.gz

    ## let it update
    /game/steamcmd/steamcmd.sh +quit

    ## link libraries
    cd /game
    mkdir -p .steam/sdk32 .steam/sdk64
    ln -s /game/steamcmd/linux32/steamclient.so .steam/sdk32/steamclient.so
    ln -s /game/steamcmd/linux64/steamclient.so .steam/sdk64/steamclient.so
  )
fi

## If no steam app set, exec into steamcmd
if [ -z ${STEAM_APPID} ]; then
  exec /game/steamcmd/steamcmd.sh $@
fi

## Configure defaults
if [[ "${STEAM_USER}" == "" ]] || [[ "${STEAM_PASS}" == "" ]]; then
    echo -e "steam user is not set.\n"
    echo -e "Using anonymous user.\n"
    STEAM_USER=anonymous
    STEAM_PASS=""
    STEAM_AUTH=""
else
    echo -e "user set to ${STEAM_USER}"
fi


/game/steamcmd/steamcmd.sh +force_install_dir /game +login ${STEAM_USER} ${STEAM_PASS} ${STEAM_AUTH} $( [[ "${STEAM_WINDOWS_INSTALL}" == "1" ]] && printf %s '+@sSteamCmdForcePlatformType windows' ) +app_update ${STEAM_APPID} $( [[ -z ${STEAM_BETAID} ]] || printf %s "-beta ${STEAM_BETAID}" ) $( [[ -z ${STEAM_BETAPASS} ]] || printf %s "-betapassword ${STEAM_BETAPASS}" ) ${INSTALL_FLAGS} validate +quit
