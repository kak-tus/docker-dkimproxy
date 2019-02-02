FROM alpine:3.9 AS build

ENV \
  CONSUL_TEMPLATE_VERSION=0.19.5 \
  CONSUL_TEMPLATE_SHA256=e6b376701708b901b0548490e296739aedd1c19423c386eb0b01cfad152162af

RUN \
  apk add --no-cache \
    curl \
    unzip \
  \
  && cd /usr/local/bin \
  && curl -L https://releases.hashicorp.com/consul-template/${CONSUL_TEMPLATE_VERSION}/consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip -o consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip \
  && echo -n "$CONSUL_TEMPLATE_SHA256  consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip" | sha256sum -c - \
  && unzip consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip \
  && rm consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip

FROM alpine:3.9

RUN \
  apk add --no-cache \
    dkimproxy

ENV \
  CONSUL_HTTP_ADDR= \
  CONSUL_TOKEN= \
  VAULT_ADDR= \
  VAULT_TOKEN= \
  \
  USER_UID=1000 \
  USER_GID=1000 \
  \
  DKIM_RELAY_ADDR=

COPY --from=build /usr/local/bin/consul-template /usr/local/bin/consul-template
COPY templates /root/templates
COPY store.sh /usr/local/bin/store.sh
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
COPY start.sh /usr/local/bin/start.sh

CMD ["/usr/local/bin/entrypoint.sh"]
