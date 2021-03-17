#
# NOTE: qbittorrent >= 4.3.0 requires libtorrent-rasterbar >= 1.2
# hence all the scattered logic written below
#

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
    build-essential \
    cmake \
    git \
    libboost-chrono-dev \
    libboost-dev \
    libboost-random-dev \
    libboost-system-dev \
    libgeoip-dev \
    libqt5svg5-dev \
    libssl-dev \
    ninja-build \
    pkg-config \
    qtbase5-dev \
    qttools5-dev \
    zlib1g-dev

# Install lintorrent-rasterbar dependencies
RUN \
  case "${TARGETPLATFORM}" in \
    'linux/amd64') export ARCH='amd64' ;; \
  esac \
  && echo "arch: ${ARCH}" \
  && \
  export LIBTORRENT_DEB="libtorrent-rasterbar10_1.2.12+git20210118.3efdb8a941-1ppa1~20.04_${ARCH}.deb" \
  && export LIBTORRENT_DEV_DEB="libtorrent-rasterbar-dev_1.2.12+git20210118.3efdb8a941-1ppa1~20.04_${ARCH}.deb" \
  && echo "libtorrent deb: ${LIBTORRENT_DEB}" \
  && echo "libtorrent-dev deb: ${LIBTORRENT_DEB}" \
  && \
  curl -fsSL -o libtorrent-rasterbar.deb \
    "https://launchpad.net/~qbittorrent-team/+archive/ubuntu/qbittorrent-stable/+files/${LIBTORRENT_DEB}" \
  && dpkg -i libtorrent-rasterbar.deb \
  && rm -rf libtorrent-rasterbar.deb \
  && \
  curl -fsSL -o libtorrent-rasterbar-dev.deb \
    "https://launchpad.net/~qbittorrent-team/+archive/ubuntu/qbittorrent-stable/+files/${LIBTORRENT_DEV_DEB}" \
  && dpkg -i libtorrent-rasterbar-dev.deb \
  && rm -rf libtorrent-rasterbar-dev.deb

# Compile qbitorrent
RUN \
  git clone --depth 1 -b release-${VERSION} https://github.com/qbittorrent/qBittorrent.git . \
  && \
  case "${TARGETPLATFORM}" in \
    'linux/arm/v7') export EXTRA_CFG_ARG="--with-boost-libdir=/usr/lib/arm-linux-gnueabihf" ;; \
  esac \
  && ./configure ${EXTRA_CFG_ARG} --disable-gui --disable-stacktrace \
  && make \
  && make install

# hadolint ignore=DL3007
FROM ghcr.io/truecharts/ubuntu:latest

ARG TARGETPLATFORM
ARG VERSION

# Proper way to set config directory
ENV HOME=/config \
    XDG_CONFIG_HOME=/config \
    XDG_DATA_HOME=/config \
    WEBUI_PORT=8080

USER root

COPY --from=builder /usr/local/bin/qbittorrent-nox /app/qbittorrent-nox

# hadolint ignore=DL3008,DL3015,SC2086
RUN \
  case "${TARGETPLATFORM}" in \
    'linux/amd64') export ARCH='amd64' ;; \
  esac \
  && \
  export LIBTORRENT_DEB="libtorrent-rasterbar10_1.2.12+git20210118.3efdb8a941-1ppa1~20.04_${ARCH}.deb" \
  && \
  curl -fsSL -o libtorrent-rasterbar.deb \
    "https://launchpad.net/~qbittorrent-team/+archive/ubuntu/qbittorrent-stable/+files/${LIBTORRENT_DEB}" \
  && dpkg -i libtorrent-rasterbar.deb \
  && rm -rf libtorrent-rasterbar.deb \
  && \
  apt-get -qq update \
  && \
  apt-get install -y \
    geoip-bin \
    libqt5network5 \
    libqt5xml5 \
    p7zip-full \
    python3 \
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
  && printf "umask %d" "${UMASK}" >> /etc/bash.bashrc \
  && update-ca-certificates

USER apps

EXPOSE 6881 6881/udp ${WEBUI_PORT}

COPY ./.containers/apps/qbittorrent/qBittorrent.conf /app/qBittorrent.conf

COPY ./.containers/apps/qbittorrent/entrypoint.sh /entrypoint.sh
CMD ["/entrypoint.sh"]

LABEL "maintainer"="TrueCharts <info@truecharts.org>"
LABEL "org.opencontainers.image.source"="https://github.com/truecharts/apps"
