FROM openjdk:8-alpine

ARG UNIFI_VERSION="${UNIFI_VERSION:-5.10.21}"

ENV UNIFI_HOME="/usr/lib/unifi"

RUN addgroup -S unifi \
  && adduser -S -G unifi unifi

RUN apk add --no-cache --update \
  bash \
  curl \
  binutils \
  su-exec \
  mongodb

RUN curl -fsSLO "https://dl.ubnt.com/unifi/${UNIFI_VERSION}/unifi_sysvinit_all.deb"
RUN ar x unifi_sysvinit_all.deb data.tar.xz
RUN tar Jxf data.tar.xz -C /
RUN ln -sf /usr/bin/mongod "${UNIFI_HOME}/bin/"
RUN chown -R unifi:unifi "${UNIFI_HOME}"
RUN rm -f unifi_sysvinit_all.deb data.tar.xz

COPY ./docker-entrypoint.sh /

WORKDIR "${UNIFI_HOME}"

HEALTHCHECK --start-period=2m --interval=5m --timeout=3s \
  CMD curl -kf https://localhost:8443 || exit 1

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD /sbin/su-exec unifi:unifi java -jar /usr/lib/unifi/lib/ace.jar start
