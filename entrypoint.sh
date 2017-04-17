#!/usr/bin/env bash

set -o errexit
set -o nounset

USER=${USER:-guest}
USER_ID=${USER_ID:-9001}

GROUPS=${GROUPS:-guest:9001}

for GROUP in $(tr ',' ' ' <<< $GROUPS); do
   groupadd --gid ${GROUP#*:} ${GROUP%:*}
done

useradd \
   --comment "containerized host user" \
   --gid $(cut -d, -f1 <<< $GROUPS | cut -d: -f2) \
   --groups $(sed 's|:[^,]*||g' <<< $GROUPS) \
   --no-create-home \
   --no-user-group \
   --non-unique \
   --shell /bin/bash \
   --uid $USER_ID \
   $USER

export HOME=/home/$USER

xhost +local:all > /dev/null

exec /usr/local/bin/gosu $USER "$@"
