FROM alpine:3.16

RUN \
  adduser -DH user \
  \
  && apk add --no-cache \
    dkimproxy

ENV DKIM_RELAY_ADDR=

CMD ["sh", "-c", "dkimproxy.out --min_servers=1 --sender_map=/etc/dkimproxy.map --user=user --group=user 0.0.0.0:10027 $DKIM_RELAY_ADDR"]
