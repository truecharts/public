# hadolint ignore=DL3007
FROM alpine:latest

ARG TARGETPLATFORM
ARG VERSION

USER root

SHELL ["/bin/ash", "-o", "pipefail", "-c"]

# hadolint ignore=DL3008,DL3015,SC2086,SC2155
RUN \
  apk add --no-cache \
    bash \
    curl \
    jq \
    ca-certificates && \
  case "${TARGETPLATFORM}" in \
    'linux/amd64') export ARCH='linux-x64' ;; \
  esac && \
  export URL=$(curl -sX GET https://api.github.com/repos/Ombi-app/Ombi/releases | \
    jq -r '.[] | select(.tag_name | contains(env.VERSION)) | .assets[] | select(.browser_download_url | contains(env.ARCH)) | .browser_download_url') && \
  curl -fsSL -o /tmp/ombi.tgz "${URL}" && \
  tar ixzf /tmp/ombi.tgz -C /app && \
  rm -rf /tmp/ombi.tgz && \
  printf "UpdateMethod=docker\nPackageVersion=%s\nPackageAuthor=[TrueCharts Project](https://truecharts.org)" "${VERSION}" > /app/package_info && \
  apk del jq && \
  rm -rf /var/cache/apk/* && \
  chmod -R u=rwX,go=rX /app && \
  printf "umask %d" "${UMASK}" >> /etc/profile && \
  update-ca-certificates

USER apps

EXPOSE 3579

COPY ./containers/apps/ombi/entrypoint.sh /entrypoint.sh
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
