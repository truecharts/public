# hadolint ignore=DL3007
FROM ghcr.io/truecharts/ubuntu:latest AS builder

# Change your name and email address
ARG DEBFULLNAME=TrueCharts
ARG DEBEMAIL=info@truecharts.org

ARG TARGETPLATFORM
ARG VERSION


# hadolint ignore=DL3002
USER root

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

WORKDIR /buildtmp
COPY ./containers/apps/build.sh /buildtmp/build.sh

# hadolint ignore=DL3008,DL3015,SC2086,SC2155,DL3047
RUN \
  mkdir /build && \
  cd /buildtmp && \
  ./build.sh


# hadolint ignore=DL3007
FROM ghcr.io/truecharts/ubuntu:latest

ARG TARGETPLATFORM
ARG VERSION

ARG DEBIAN_FRONTEND=noninteractive
ARG SOGO_UBUNTU_REPOSITORY=https://packages.inverse.ca/SOGo/nightly/5/ubuntu/
ENV LC_ALL C
ENV GOSU_VERSION 1.12

# hadolint ignore=DL3002
USER root

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
COPY --from=builder /buildtmp/vendor/ /build

# hadolint ignore=DL3008,DL3015,SC2086,SC2155,DL3047
RUN \
  apt-get -qq update \
  && \
  apt-get -qq install -y \
    libicu66 \
    jq \
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
    apache2 \
  && \
  case "${TARGETPLATFORM}" in \
    'linux/amd64') export ARCH='linux-x64' ;; \
  esac \
  && \
  echo "Building from repository $SOGO_UBUNTU_REPOSITORY" && \
  apt-get install -yq --no-install-recommends apt-transport-https ca-certificates dirmngr gnupg2 && \
  mkdir ~/.gnupg && \
  echo "disable-ipv6" >> ~/.gnupg/dirmngr.conf && \
  apt-key adv --keyserver keyserver.ubuntu.com --recv-key 0x810273C4 && \
  echo "deb ${SOGO_UBUNTU_REPOSITORY} focal focal" > /etc/apt/sources.list.d/SOGo.list && \
  mkdir /usr/share/doc/sogo && \
  touch /usr/share/doc/sogo/empty.sh && \
  apt-get update -qq && \
  apt-get install -yq --no-install-recommends sogo sogo-activesync sope4.9-gdl1-postgresql sope4.9-gdl1-mysql && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
  a2enmod headers proxy proxy_http rewrite ssl && \
  cp /etc/apache2/conf.d/SOGo.conf /etc/apache2/conf-available/ && \
  sed -i -e 's/#RedirectMatch \^\/\$ https:\/\/mail.yourdomain.com\/SOGo/RedirectMatch \^\/\$ \/SOGo/' /etc/apache2/conf-available/SOGo.conf && \
  a2enconf SOGo && \
  usermod --home /srv/lib/sogo sogo

EXPOSE 80 443

COPY ./containers/apps/sogo/etc /etc
COPY ./containers/apps/sogo/entrypoint.sh /entrypoint.sh


CMD ["supervisord", "-c", "/etc/supervisor/supervisord.conf"]

LABEL "maintainer"="TrueCharts <info@truecharts.org>"
LABEL "org.opencontainers.image.source"="https://github.com/truecharts/apps"
