#!/usr/bin/env sh

deluser user 2>/dev/null
delgroup user 2>/dev/null
addgroup -g $USER_GID user
adduser -h /home/user -G user -D -u $USER_UID user

consul-template -config /etc/dkimproxy.hcl &
child=$!

trap "kill $child" INT TERM
wait "$child"
