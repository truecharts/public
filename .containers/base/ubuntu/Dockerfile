ARG VERSION

FROM ubuntu:${VERSION}

ARG TARGETPLATFORM

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# DEBIAN_FRONTEND: https://askubuntu.com/questions/972516/debian-frontend-environment-variable
# APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE: http://stackoverflow.com/questions/48162574/ddg#49462622
ENV \
  DEBCONF_NONINTERACTIVE_SEEN=true \
  DEBIAN_FRONTEND="noninteractive" \
  APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=DontWarn \
  TINI_VERSION=0.19.0 \
  UMASK=0002 \
  LANG=en_US.UTF-8 \
  LANGUAGE=en_US:en \
  LC_ALL=en_US.UTF-8 \
  MICRO_CONFIG_HOME=/tmp

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
  && echo 'APT::Install-Recommends "false";' >/etc/apt/apt.conf.d/00recommends \
  && echo 'APT::Install-Suggests "false";' >>/etc/apt/apt.conf.d/00recommends \
  && echo 'APT::Get::Install-Recommends "false";' >>/etc/apt/apt.conf.d/00recommends \
  && echo 'APT::Get::Install-Suggests "false";' >>/etc/apt/apt.conf.d/00recommends \
  && \
  apt-get -qq update \
  && \
  apt-get install -y \
    bash \
    ca-certificates \
    curl \
    jq \
    locales \
    tini \
    tzdata \
  && locale-gen en_US.UTF-8 \
  && update-locale \
  && dpkg-reconfigure -f noninteractive locales \
  && MICRO_VERSION=$(curl -s "https://api.github.com/repos/zyedidia/micro/releases" | jq --raw-output '.[0].tag_name') \
  && MICRO_VERSION="${MICRO_VERSION#?}" \
  && curl -fsSL "https://github.com/zyedidia/micro/releases/download/v${MICRO_VERSION}/micro-${MICRO_VERSION}-linux64.tar.gz" | tar xzf - -C /tmp --strip-components=1 \
  && mv /tmp/micro /usr/local/bin/micro \
  && ln -s /usr/local/bin/micro /usr/local/bin/vi \
  && ln -s /usr/local/bin/micro /usr/local/bin/vim \
  && ln -s /usr/local/bin/micro /usr/local/bin/nano \
  && ln -s /usr/local/bin/micro /usr/local/bin/emacs \
  && unset MICRO_ARCH \
  && unset MICRO_VERSION \
  && \
  printf "/bin/bash /shim/greeting.sh" >> /etc/bash.bashrc \
  && \
  apt-get remove -y jq \
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
ENTRYPOINT [ "/usr/bin/tini", "--" ]

LABEL "maintainer"="TrueCharts <info@truecharts.org>"
LABEL "org.opencontainers.image.source"="https://github.com/truecharts/apps"
