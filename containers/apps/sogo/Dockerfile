# hadolint ignore=DL3007
FROM ghcr.io/truecharts/ubuntu:latest


ARG TARGETPLATFORM
ARG VERSION

ARG DEBIAN_FRONTEND=noninteractive
ARG SOGO_DEBIAN_REPOSITORY=https://packages.inverse.ca/SOGo/nightly/5/ubuntu/
ENV LC_ALL C
ENV GOSU_VERSION 1.12

# hadolint ignore=DL3002
USER root

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# hadolint ignore=DL3008,DL3015,SC2086,SC2155,DL3047
RUN \
  apt-get -qq update \
  && \
  apt-get -qq install -y \
    libicu66 \
    jq \
  && \
  case "${TARGETPLATFORM}" in \
    'linux/amd64') export ARCH='linux-x64' ;; \
  esac \
  && \
  echo "Building from repository $SOGO_DEBIAN_REPOSITORY" \
  && apt-get update && apt-get install -y --no-install-recommends \
  apt-transport-https \
  ca-certificates \
  gettext \
  gnupg \
  mariadb-client \
  rsync \
  supervisor \
  syslog-ng \
  syslog-ng-core \
  syslog-ng-mod-redis \
  dirmngr \
  netcat \
  psmisc \
  wget \
  patch \
  && dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')" \
  && wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch" \
  && chmod +x /usr/local/bin/gosu \
  && gosu nobody true \
  && mkdir /usr/share/doc/sogo \
  && touch /usr/share/doc/sogo/empty.sh \
  && apt-key adv --keyserver keyserver.ubuntu.com --recv-key 0x810273C4 \
  && echo "deb ${SOGO_DEBIAN_REPOSITORY} buster buster" > /etc/apt/sources.list.d/sogo.list \
  && apt-get update && apt-get install -y --no-install-recommends \
    sogo \
    sogo-activesync \
  && apt-get autoclean \
  && rm -rf /var/lib/apt/lists/* /etc/apt/sources.list.d/sogo.list \
  && touch /etc/default/locale \
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

EXPOSE 80 443

COPY ./containers/apps/sogo/entrypoint.sh /entrypoint.sh
COPY ./containers/apps/sogo/bootstrap-sogo.sh /bootstrap-sogo.sh
COPY ./containers/apps/sogo/syslog-ng.conf /etc/syslog-ng/syslog-ng.conf
COPY ./containers/apps/sogo/supervisord.conf /etc/supervisor/supervisord.conf
COPY ./containers/apps/sogo/stop-supervisor.sh /usr/local/sbin/stop-supervisor.sh

RUN chmod +x /bootstrap-sogo.sh \
  /usr/local/sbin/stop-supervisor.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["exec","/usr/bin/supervisord","-c","/etc/supervisor/supervisord.conf"]

LABEL "maintainer"="TrueCharts <info@truecharts.org>"
LABEL "org.opencontainers.image.source"="https://github.com/truecharts/apps"
