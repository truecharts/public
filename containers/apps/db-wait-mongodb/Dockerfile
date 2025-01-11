# hadolint ignore=DL3007
FROM tccr.io/tccr/alpine:latest@sha256:ec64547ad03f8d44c8d361fb3542df8cfe1012d8d79fe13fbb7ba977f07f6d7c

ARG TARGETPLATFORM
ARG VERSION

USER root

SHELL ["/bin/sh", "-o", "pipefail", "-c"]

# hadolint ignore=DL3008,DL3015,SC2086,SC2155,DL4001
RUN \
  apk update && \
  apk add --no-cache \
    curl \
    ca-certificates \
    gnupg \
    bash && \
  curl -fsSLo /etc/apk/keys/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg && \
  echo "https://dl-cdn.alpinelinux.org/alpine/v3.16/community" >> /etc/apk/repositories && \
  curl -fsSL https://downloads.mongodb.com/compass/mongosh-1.8.0-linux-x64.tgz -o /tmp/mongosh.tgz && \
  tar -xvzf /tmp/mongosh.tgz -C /tmp && \
  mv /tmp/mongosh*/bin/mongosh /usr/local/bin/ && \
  chmod +x /usr/local/bin/mongosh && \
  apk del gnupg && \
  case "${TARGETPLATFORM}" in \
    'linux/amd64') export ARCH='linux-x64' ;; \
  esac && \
  rm -rf /tmp/* /var/cache/apk/* && \
  chmod -R u=rwX,go=rX /app && \
  printf "umask %d" "${UMASK}" >> /etc/profile && \
  update-ca-certificates

USER apps

COPY ./containers/apps/db-wait-mongodb/entrypoint.sh /entrypoint.sh
CMD ["/entrypoint.sh"]

LABEL "maintainer"="TrueCharts <info@truecharts.org>"
LABEL "org.opencontainers.image.source"="https://github.com/truecharts/apps"

ARG CONTAINER_NAME
ARG CONTAINER_VER
LABEL org.opencontainers.image.licenses="BSD-3-Clause"
LABEL org.opencontainers.image.title="${CONTAINER_NAME}"
LABEL org.opencontainers.image.url="https://truecharts.org/docs/charts/${CONTAINER_NAME}"
LABEL org.opencontainers.image.version="${CONTAINER_VER}"
LABEL org.opencontainers.image.description="Container for ${CONTAINER_NAME} by TrueCharts"
LABEL org.opencontainers.image.authors="TrueCharts"
LABEL org.opencontainers.image.documentation="https://truecharts.org/docs/charts/${CONTAINER_NAME}"
