FROM adoptopenjdk/openjdk8:alpine

ARG CONFLUENCE_VERSION="${CONFLUENCE_VERSION:-6.14.2}"

ENV CONFLUENCE_PATH="/opt/confluence"
ENV CONFLUENCE_HOME="/var/confluence"
ENV LANG="C.UTF-8"

RUN addgroup -S confluence \
  && adduser -S -G confluence confluence

RUN apk add --no-cache --update \
  bash \
  curl \
  su-exec \
  tar \
  ttf-dejavu \
  xmlstarlet

RUN curl -fsSL "https://product-downloads.atlassian.com/software/confluence/downloads/atlassian-confluence-${CONFLUENCE_VERSION}.tar.gz" \
  | tar zxvf - -C /opt --transform "s/atlassian-confluence-${CONFLUENCE_VERSION}/confluence/"

RUN echo "confluence.home=${CONFLUENCE_HOME}" > "${CONFLUENCE_PATH}/confluence/WEB-INF/classes/confluence-init.properties"

RUN chown -R confluence:confluence "${CONFLUENCE_PATH}"

COPY ./docker-entrypoint.sh /

HEALTHCHECK --start-period=2m --interval=5m --timeout=3s \
  CMD curl -f http://localhost:8090 || exit 1

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD /sbin/su-exec confluence:confluence /opt/confluence/bin/start-confluence.sh -fg
