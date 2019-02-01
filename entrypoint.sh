#!/usr/bin/env sh

addgroup -g $USER_GID user
adduser -h /home/user -G user -D -u $USER_UID user

consul-template -config /root/templates/service.hcl &
child=$!

trap "kill $child" INT TERM
wait "$child"
trap - INT TERM
wait "$child"
