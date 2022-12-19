#!/bin/bash
if [ $# -ne 1 ] ; then 
    echo "[fail] usage: <host>"
    exit 1;
fi
set -e
BASE=$(
    cd "$(dirname "$0")"
    pwd -P
)
HOST=$1
NAME=clef-host
USER=env
sh $BASE/make.sh
exit
ssh -T $USER@$HOST "bash -s" <<END_SSH
rm -fr /home/$USER/$NAME/
mkdir -p /home/$USER/$NAME
END_SSH

scp $BASE/.make/$NAME.gzip env@$HOST:/home/env/$NAME/
ssh -T $USER@$HOST "bash -s" <<END_SSH
if [ ! -d /home/ops/$NAME ] ; then
    sudo mkdir /home/ops/$NAME
fi
if [ -f /home/ops/$NAME/$NAME.sh ] ; then
    sudo -u ops sh /home/ops/$NAME/$NAME.sh stop
fi
sudo rm -fr /home/ops/$NAME/*
sudo tar xvf /home/env/$NAME/$NAME.gzip -C /home/ops/$NAME
sudo chown -R ops:ops /home/ops
sudo -u ops sh /home/ops/$NAME/$NAME.sh host
END_SSH
exit
