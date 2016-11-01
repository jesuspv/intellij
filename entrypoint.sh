#!/bin/bash

USER=${USER:-guest}
USER_ID=${USER_ID:-9001}

GROUP=${GROUP:-guest}
GROUP_ID=${GROUP_ID:-9001}

# TODO add all host user groups as well (not only the main group)
groupadd -g $GROUP_ID $GROUP
# redirecting stderr to hide 'warning: the home directory already exists' (due to --volume's on $HOME)
useradd --shell /bin/bash -u $USER_ID -g $GROUP -o -c "" -m $USER 2> /dev/null
export HOME=/home/$USER

mkdir -p $HOME/host
cd $HOME/host

xhost +local:all

exec /usr/local/bin/gosu $USER "$@"
