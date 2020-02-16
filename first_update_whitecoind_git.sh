#!/bin/bash
#1. This script place into /home/pi/script, out of /home/pi/whitecoind_sync
#2. first git glone whitecoind_sync from github
#3. goto /home/pi/whitecoind_sync
#4. run /home/pi/whitecoind_sync/git_update_main.sh
#
#. common.sh
. git_sync_whitecoind.sh

if repeat_sync_whitecoind
then
  cd ${whitecoind_work}
  git_update_main.sh
fi
