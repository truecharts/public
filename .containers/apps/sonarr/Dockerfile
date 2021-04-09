# hadolint ignore=DL3007
FROM ghcr.io/truecharts/ubuntu:latest

ARG VERSION

USER root

# https://download.mono-project.com/repo/ubuntu/dists/focal/snapshots/
ENV MONO_VERSION=6.12.0.122

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# hadolint ignore=DL3008,DL3015,SC2086
RUN \
  apt-get -qq update \
  && apt-get -qq install -y gnupg \
    && \
  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF \
  && echo "deb https://download.mono-project.com/repo/ubuntu focal/snapshots/${MONO_VERSION} main" | tee /etc/apt/sources.list.d/mono-official.list \
  && apt-get -qq update \
  && \
  apt-get -qq install -y \
    mono-complete=${MONO_VERSION}\* \
    libmediainfo0v5 \
  && \
  curl -fsSL -o /tmp/sonarr.tar.gz \
    "https://download.sonarr.tv/v3/main/${VERSION}/Sonarr.main.${VERSION}.linux.tar.gz" \
  && tar ixzf /tmp/sonarr.tar.gz -C /app --strip-components 1 \
  && \
  rm -rf \
    /app/Sonarr.Update* \
  && \
  printf "UpdateMethod=docker\nBranch=main\nPackageVersion=%s\nPackageAuthor=[TrueCharts Project](https://truecharts.org)" "${VERSION}" > /app/package_info \
  && \
  gpgconf --kill all \
  && apt-get remove -y gnupg2 \
  && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
  && apt-get autoremove -y \
  && apt-get clean \
  && \
  rm -rf \
    /tmp/* \
    /var/lib/apt/lists/* \
    /var/cache/apt/* \
    /var/tmp/ \
  && chmod -R u=rwX,go=rX /app \
  && printf "umask %d" "${UMASK}" >> /etc/bash.bashrc \
  && update-ca-certificates

USER apps

EXPOSE 8989

COPY ./.containers/apps/sonarr/entrypoint.sh /entrypoint.sh
CMD ["/entrypoint.sh"]

LABEL "maintainer"="TrueCharts <info@truecharts.org>"
LABEL "org.opencontainers.image.source"="https://github.com/truecharts/apps"
