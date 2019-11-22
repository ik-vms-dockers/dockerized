FROM python:3-alpine

ARG CERTBOT_VERSION="${CERTBOT_VERSION:-}"
ARG CERTBOT_PLUGINS="${CERTBOT_PLUGINS:-}"

RUN apk add -q --no-cache --update \
  build-base \
  libffi-dev \
  libxml2-dev \
  libxslt-dev \
  openssl-dev

RUN pip install -q --no-cache-dir \
  pyyaml \
  certbot \
  ${CERTBOT_PLUGINS}

COPY ./run.py /

CMD ["python", "-u", "/run.py"]
