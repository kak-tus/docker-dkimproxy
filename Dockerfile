FROM alpine:3.4

COPY consul-template_0.18.0-rc2_SHA256SUMS /usr/local/bin/consul-template_0.18.0-rc2_SHA256SUMS

RUN \
  apk add --update-cache curl unzip dkimproxy \

  && cd /usr/local/bin \
  && curl -L https://releases.hashicorp.com/consul-template/0.18.0-rc2/consul-template_0.18.0-rc2_linux_amd64.zip -o consul-template_0.18.0-rc2_linux_amd64.zip \
  && sha256sum -c consul-template_0.18.0-rc2_SHA256SUMS \
  && unzip consul-template_0.18.0-rc2_linux_amd64.zip \
  && rm consul-template_0.18.0-rc2_linux_amd64.zip consul-template_0.18.0-rc2_SHA256SUMS \

  && apk del curl unzip && rm -rf /var/cache/apk/*

ENV CONSUL_HTTP_ADDR=
ENV CONSUL_TOKEN=
ENV VAULT_ADDR=
ENV VAULT_TOKEN=
ENV USER_UID=1000
ENV USER_GID=1000

COPY dkimproxy.hcl /etc/dkimproxy.hcl
COPY store.sh /usr/local/bin/store.sh
COPY dkimproxy.map.template /root/dkimproxy.map.template
COPY start_dkimproxy.sh.template /root/start_dkimproxy.sh.template
COPY start_template.sh /usr/local/bin/start_template.sh

CMD /usr/local/bin/start_template.sh
