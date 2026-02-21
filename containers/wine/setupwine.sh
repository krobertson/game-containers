#!/bin/bash

# Initialize wineprefix
wineboot --init --update

# If no winetricks to install, just exit
if [ ! -z ${WINETRICKS} ]; then
  exit 0
fi

# Instrument xvfb to run winetricks
exec 6>display.log
/usr/bin/Xvfb -displayfd 6 -nolisten tcp -nolisten unix &
XVFB_PID=$!
while [[ ! -s display.log ]]; do
  sleep 1
done
read -r DPY_NUM < display.log
rm display.log
export DISPLAY=:${DPY_NUM}

# Install packages
for PACKAGE in ${WINETRICKS}; do
  winetricks -q ${PACKAGE}
done
rm -rf ~/.cache/winetricks ~/.cache/fontconfig

exec 6>&-
kill ${XVFB_PID}

# We don't want to use the exit code from the kill call
exit 0
