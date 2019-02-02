#!/usr/bin/env sh

dkimproxy.out \
  --sender_map=/etc/dkimproxy.map \
  --user=user --group=user \
  0.0.0.0:10027 \
  "$DKIM_RELAY_ADDR" &

child=$!

trap "kill $child" INT TERM
wait "$child"
trap - INT TERM
wait "$child"
