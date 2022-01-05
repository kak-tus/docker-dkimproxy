FROM alpine:3.15

RUN \
  adduser -DH user \
  \
  && apk add --no-cache \
    dkimproxy

ENV DKIM_RELAY_ADDR=

CMD ["sh", "-c", "dkimproxy.out --sender_map=/etc/dkimproxy.map --user=user --group=user 0.0.0.0:10027 $DKIM_RELAY_ADDR"]
