#!/bin/bash

if [[ -n "${CONFLUENCE_URL}" ]]; then
  xmlstarlet ed --inplace --update "/Server/Service/Connector/@scheme" -v "https" --insert "/Server/Service/Connector[not(@scheme)]" --type attr -n scheme -v "https" ${CONFLUENCE_PATH}/conf/server.xml
  xmlstarlet ed --inplace --update "/Server/Service/Connector/@proxyPort" -v "443" --insert "/Server/Service/Connector[not(@proxyPort)]" --type attr -n proxyPort -v "443" ${CONFLUENCE_PATH}/conf/server.xml
  xmlstarlet ed --inplace --update "/Server/Service/Connector/@proxyName" -v "${CONFLUENCE_URL}" --insert "/Server/Service/Connector[not(@proxyName)]" --type attr -n proxyName -v "${CONFLUENCE_URL}" ${CONFLUENCE_PATH}/conf/server.xml
fi

if [[ -n "${CONFLUENCE_MEM}" ]]; then
  sed -i -e "s/Xms[0-9]+m/Xms${CONFLUENCE_MEM}m/" -e "s/Xmx[0-9]+m/Xmx${CONFLUENCE_MEM}m/" ${CONFLUENCE_PATH}/bin/setenv.sh
fi

chown -R confluence:confluence "${CONFLUENCE_HOME}" "${CONFLUENCE_PATH}"

exec "$@"
