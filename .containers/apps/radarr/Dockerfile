# hadolint ignore=DL3007
FROM ghcr.io/truecharts/ubuntu:latest

ARG TARGETPLATFORM
ARG VERSION

USER root

# hadolint ignore=DL3008,DL3015
RUN \
  apt-get -qq update \
  && \
  apt-get -qq install -y \
    libicu66 \
    mediainfo \
  && \
  case "${TARGETPLATFORM}" in \
    'linux/amd64') export ARCH='x64' ;; \
  esac \
  && \
  curl -fsSL -o /tmp/radarr.tar.gz \
    "https://radarr.servarr.com/v1/update/develop/updatefile?version=${VERSION}&os=linux&runtime=netcore&arch=${ARCH}" \
  && tar ixzf /tmp/radarr.tar.gz -C /app --strip-components 1 \
  && \
  rm -rf \
    /app/Radarr.Update* \
  && \
  printf "UpdateMethod=docker\nBranch=develop\nPackageVersion=%s\nPackageAuthor=[TrueCharts Project](https://truecharts.org)" "${VERSION}" > /app/package_info \
  && \
  apt-get autoremove -y \
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

EXPOSE 7878

COPY ./.containers/apps/radarr/entrypoint.sh /entrypoint.sh
CMD ["/entrypoint.sh"]

LABEL "maintainer"="TrueCharts <info@truecharts.org>"
LABEL "org.opencontainers.image.source"="https://github.com/truecharts/apps"
