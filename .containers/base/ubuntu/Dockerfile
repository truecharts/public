ARG VERSION

FROM ubuntu:${VERSION}

ARG TARGETPLATFORM

ENV \
  DEBCONF_NONINTERACTIVE_SEEN=true \
  DEBIAN_FRONTEND=noninteractive \
  TINI_VERSION=0.19.0 \
  UMASK=0002

RUN \
  adduser apps \
  --uid 568 \
  --group \
  --system \
  --disabled-password \
  --no-create-home \
  && \
  mkdir -p /config \
  && chown -R apps:apps /config

WORKDIR /app

# hadolint ignore=DL3008,DL3015
RUN \
  set -eux \
  && \
  case "${TARGETPLATFORM}" in \
    'linux/amd64') export ARCH='amd64' ;; \
  esac \
  && \
  echo 'APT::Install-Recommends "false";' >/etc/apt/apt.conf.d/00recommends \
  && echo 'APT::Install-Suggests "false";' >>/etc/apt/apt.conf.d/00recommends \
  && echo 'APT::Get::Install-Recommends "false";' >>/etc/apt/apt.conf.d/00recommends \
  && echo 'APT::Get::Install-Suggests "false";' >>/etc/apt/apt.conf.d/00recommends \
  && \
  apt-get -qq update \
  && \
  apt-get install -y \
    ca-certificates \
    curl \
    gnupg2 \
    locales \
    tzdata \
    vim \
  && locale-gen en_US.UTF-8 \
  && curl -fsSL -o /sbin/tini "https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini-${ARCH}" \
  && curl -fsSL -o /tini.asc "https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini-${ARCH}.asc" \
  && gpg --batch --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 595E85A6B1B4779EA4DAAEC70B588DFF0527A9B7 \
  && gpg --batch --verify /tini.asc /sbin/tini \
  && chmod +x /sbin/tini \
  && gpgconf --kill all \
  && \
  apt-get remove -y \
    gnupg2 \
  && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
  && apt-get autoremove -y \
  && apt-get clean \
  && \
  rm -rf \
    /tini.asc \
    /tmp/* \
    /var/lib/apt/lists/* \
    /var/cache/apt/* \
    /var/tmp/*

USER apps

VOLUME [ "/config" ]

COPY ./.containers/base/ubuntu/shim /shim
ENTRYPOINT [ "/sbin/tini", "--" ]

LABEL "maintainer"="TrueCharts <info@truecharts.org>"
LABEL "org.opencontainers.image.source"="https://github.com/truecharts/apps"
