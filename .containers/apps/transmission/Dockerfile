# hadolint ignore=DL3007
FROM ghcr.io/truecharts/ubuntu:latest as builder

ARG TARGETPLATFORM
ARG VERSION

# hadolint ignore=DL3002
USER root

WORKDIR /tmp

# Install system dependencies
# hadolint ignore=DL3008
RUN \
  apt-get -qq update \
  && \
  apt-get -qq install -y --no-install-recommends \
    autoconf \
    automake \
    build-essential \
    cmake \
    git \
    intltool \
    libappindicator3-dev \
    libcurl4-openssl-dev \
    libevent-dev \
    libglib2.0-dev \
    libminiupnpc-dev \
    libssh-dev \
    libtool \
    pkg-config

# Compile transmission
RUN \
  git clone --depth 1 -b ${VERSION} https://github.com/transmission/transmission.git . \
  && git submodule update --init \
  && ./autogen.sh --without-gtk \
  && make -s \
  && make install

# hadolint ignore=DL3007
FROM ghcr.io/truecharts/ubuntu:latest

ARG TARGETPLATFORM
ARG VERSION

# Proper way to set config directory
ENV HOME=/config \
    XDG_CONFIG_HOME=/config \
    XDG_DATA_HOME=/config \
    WEBUI_PORT=9091 \
    TRANSMISSION_WEB_HOME=/web

USER root

COPY --from=builder /usr/local/bin/transmission-daemon /app/transmission-daemon
COPY --from=builder /usr/local/share/transmission/web /web

# hadolint ignore=DL3008,DL3015
RUN \
  apt-get -qq update \
  && \
  apt-get install -y \
    libevent-dev \
    libminiupnpc-dev \
    p7zip-full \
    python3 \
    rsync \
    unrar \
    unzip \
  && \
  printf "UpdateMethod=docker\nPackageVersion=%s\nPackageAuthor=[TrueCharts Project](https://truecharts.org)" "${VERSION}" > /app/package_info \
  && \
  apt-get autoremove -y \
  && apt-get clean \
  && \
  rm -rf \
    /tmp/* \
    /var/lib/apt/lists/* \
    /var/tmp/ \
  && chmod -R u=rwX,go=rX /app \
  && chmod -R u=rwX,go=rX /web \
  && printf "umask %d" "${UMASK}" >> /etc/bash.bashrc \
  && update-ca-certificates

USER apps

EXPOSE ${WEBUI_PORT} 51413

COPY ./.containers/apps/transmission/entrypoint.sh /entrypoint.sh
CMD ["/entrypoint.sh"]

LABEL "maintainer"="TrueCharts <info@truecharts.org>"
LABEL "org.opencontainers.image.source"="https://github.com/truecharts/apps"
