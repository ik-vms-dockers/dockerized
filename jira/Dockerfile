FROM adoptopenjdk/openjdk8:alpine

ARG JIRA_VERSION="${JIRA_VERSION:-8.0.2}"

ENV JIRA_PATH="/opt/jira"
ENV JIRA_HOME="/var/jira"
ENV LANG="C.UTF-8"

RUN addgroup -S jira \
  && adduser -S -G jira jira

RUN apk add --no-cache --update \
  bash \
  curl \
  su-exec \
  tar \
  ttf-dejavu \
  xmlstarlet

RUN curl -fsSL "https://product-downloads.atlassian.com/software/jira/downloads/atlassian-jira-software-${JIRA_VERSION}.tar.gz" \
  | tar zxvf - -C /opt --transform "s/atlassian-jira-software-${JIRA_VERSION}-standalone/jira/"

RUN echo "jira.home=${JIRA_HOME}" > "${JIRA_PATH}/atlassian-jira/WEB-INF/classes/jira-application.properties"

RUN chown -R jira:jira "${JIRA_PATH}"

COPY ./docker-entrypoint.sh /

HEALTHCHECK --start-period=2m --interval=5m --timeout=3s \
  CMD curl -f http://localhost:8080 || exit 1

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD /sbin/su-exec jira:jira /opt/jira/bin/start-jira.sh -fg
