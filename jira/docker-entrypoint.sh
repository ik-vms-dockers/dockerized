#!/bin/bash

if [[ -n "${JIRA_URL}" ]]; then
  xmlstarlet ed --inplace --update "/Server/Service/Connector/@scheme" -v "https" --insert "/Server/Service/Connector[not(@scheme)]" --type attr -n scheme -v "https" ${JIRA_PATH}/conf/server.xml
  xmlstarlet ed --inplace --update "/Server/Service/Connector/@proxyPort" -v "443" --insert "/Server/Service/Connector[not(@proxyPort)]" --type attr -n proxyPort -v "443" ${JIRA_PATH}/conf/server.xml
  xmlstarlet ed --inplace --update "/Server/Service/Connector/@proxyName" -v "${JIRA_URL}" --insert "/Server/Service/Connector[not(@proxyName)]" --type attr -n proxyName -v "${JIRA_URL}" ${JIRA_PATH}/conf/server.xml
fi

if [[ -n "${JIRA_MAX_MEM}" ]]; then
  sed -i -e "s/Xms[0-9]+m/Xms${JIRA_MAX_MEM}m/" -e "s/Xmx[0-9]+m/Xmx${JIRA_MAX_MEM}m/" ${JIRA_PATH}/bin/setenv.sh
fi

chown -R jira:jira "${JIRA_HOME}" "${JIRA_PATH}"

exec "$@"
