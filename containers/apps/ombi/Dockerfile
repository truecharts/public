# hadolint ignore=DL3007
FROM ghcr.io/truecharts/ubuntu:latest@sha256:cbe66cbca1ddd2a82093675067c363af8bbc6713b645bc77cb1706578a01facd

ARG TARGETPLATFORM
ARG VERSION

USER root

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# hadolint ignore=DL3008,DL3015,SC2086,SC2155
RUN \
  apt-get -qq update \
  && \
  case "${TARGETPLATFORM}" in \
    'linux/amd64') export ARCH='linux-x64' ;; \
  esac \
  && \
  export URL=$(curl -sX GET https://api.github.com/repos/Ombi-app/Ombi/releases | \
    jq -r '.[] | select(.tag_name | contains(env.VERSION)) | .assets[] | select(.browser_download_url | contains(env.ARCH)) | .browser_download_url') \
  && curl -fsSL -o /tmp/ombi.tgz "${URL}" \
  && tar ixzf /tmp/ombi.tgz -C /app \
  && \
  rm -rf \
    /tmp/ombi.tgz \
  && printf "UpdateMethod=docker\nPackageVersion=%s\nPackageAuthor=[TrueCharts Project](https://truecharts.org)" "${VERSION}" > /app/package_info \
  && apt-get remove -y \
    jq \
  && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
  && apt-get autoremove -y \
  && apt-get clean \
  && \
  rm -rf \
    /tmp/* \
    /var/lib/apt/lists/* \
    /var/tmp/ \
  && chmod -R u=rwX,go=rX /app \
  && printf "umask %d" "${UMASK}" >> /etc/bash.bashrc \
  && update-ca-certificates

USER apps

EXPOSE 3579

COPY ./apps/ombi/entrypoint.sh /entrypoint.sh
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
