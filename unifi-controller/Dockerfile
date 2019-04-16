FROM openjdk:8-alpine

ARG UNIFI_VERSION="${UNIFI_VERSION:-5.10.21}"

RUN addgroup -S unifi \
  && adduser -S -G unifi unifi

RUN apk add --no-cache --update \
  bash \
  binutils \
  su-exec \
  mongodb \
  wget 

WORKDIR /tmp 

RUN wget -q "https://dl.ubnt.com/unifi/${UNIFI_VERSION}/unifi_sysvinit_all.deb"
RUN ar x unifi_sysvinit_all.deb
RUN tar Jxf data.tar.xz -C /
RUN ln -sf /usr/bin/mongod /usr/lib/unifi/bin/
RUN chown -R unifi:unifi /usr/lib/unifi
RUN rm -rf /tmp/*

WORKDIR /usr/lib/unifi

COPY ./docker-entrypoint.sh /

HEALTHCHECK --start-period=2m --interval=5m --timeout=3s \
  CMD curl -kf https://localhost:8443 || exit 1

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD /sbin/su-exec unifi:unifi java -jar /usr/lib/unifi/lib/ace.jar start
